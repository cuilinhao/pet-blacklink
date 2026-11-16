#!/usr/bin/env python3
"""Record one inspected Pettenderly platform outcome and advance its daily cursor.

This command never creates queue candidates. Call it only after a real browser
inspection/submission, with the exact source key printed by resume_gate.rb.
"""

import argparse
import csv
import fcntl
import io
import os
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime
from pathlib import Path
from urllib.parse import urlparse
from zoneinfo import ZoneInfo


WEBSITE = "Pettenderly"
SOURCE = "success_platform_01.csv"
ALLOWED_CSVS = ('success-1103-image-generator-blog-comment-100-2026-11-03.csv', 'success-1104-daohang-613-final.csv', 'success-外链网站合并去重_2026-11-05.csv', 'success_platform_001.csv', 'success_platform_01.csv', 'success_platform_02.csv', 'success_platform_02_queue.csv')
HEADERS = (
    "website", "csv", "source_key", "platform", "platform_url", "state",
    "last_status", "last_attempted", "evidence_url", "notes",
)
COUNTED = {
    "submitted", "submitted-pending-review", "pending review", "public",
    "public-counted", "public-listed", "live", "verified", "scheduled",
}
GATE = Path(__file__).resolve().parents[2] / "skills" / "backlink-automation-submission" / "scripts" / "resume_gate.rb"
BREW_RUBY = Path("/opt/homebrew/opt/ruby/bin/ruby")
RUBY = str(BREW_RUBY) if BREW_RUBY.is_file() else "ruby"


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--workspace", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--csv", default=SOURCE, choices=ALLOWED_CSVS, help="Active queue filename")
    parser.add_argument("--source-key", required=True, help="Exact key from resume_gate.rb")
    parser.add_argument("--platform", required=True, help="Exact platform label from the source CSV")
    parser.add_argument("--url", required=True, help="Exact platform URL from the source CSV")
    parser.add_argument("--status", required=True, help="Observed status, e.g. submitted or paid")
    parser.add_argument("--state", required=True, choices=("terminal", "deferred"))
    parser.add_argument("--evidence", default="", help="Receipt, dashboard, or public URL")
    parser.add_argument("--notes", required=True, help="Observed result; no secrets")
    parser.add_argument("--next-step", help="For uncounted daily row; defaults to notes")
    parser.add_argument("--date", default=datetime.now(ZoneInfo("Asia/Shanghai")).date().isoformat(),
                        help="Shanghai-local run date")
    parser.add_argument("--goal", type=int, help="Daily target, only if set for this run")
    parser.add_argument("--at", help="Client-local YYYY-MM-DD HH:MM; defaults to now")
    return parser.parse_args()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def valid_web_url(value):
    parsed = urlparse(value)
    return parsed.scheme in {"http", "https"} and bool(parsed.netloc)


def gate(workspace, active_csv, today, allow_exhausted=False, expect_next=None):
    command = [
        RUBY, str(GATE), "--workspace", str(workspace),
        "--website", WEBSITE, "--active-csv", active_csv,
        "--today", today,
    ]
    if expect_next:
        command += ["--expect-next-source-key", expect_next]
    process = subprocess.run(command, text=True, capture_output=True)
    result = dict(line.split("=", 1) for line in process.stdout.splitlines() if "=" in line)
    if process.returncode == 0 and result.get("RESUME_GATE") == "PASS":
        return result
    exhausted_message = f"ERROR: no unprocessed candidate remains in {active_csv}"
    exhausted = (
        allow_exhausted and process.returncode == 2
        and result.get("RESUME_GATE") == "FAIL"
        and not result.get("next_source_key")
        and result.get("active_remaining_rows") == "0"
        and result.get("active_handled_rows") == result.get("active_total_rows")
        and process.stderr.strip() == exhausted_message
    )
    require(exhausted,
            f"resume gate failed for {active_csv}: {process.stdout.strip()} {process.stderr.strip()}")
    result["queue_exhausted"] = "true"
    return result


def read_progress(path):
    with path.open(newline="", encoding="utf-8-sig") as handle:
        reader = csv.DictReader(handle)
        require(reader.fieldnames == list(HEADERS), "unexpected progress CSV columns")
        return list(reader)


def render_progress(rows):
    output = io.StringIO(newline="")
    writer = csv.DictWriter(output, fieldnames=HEADERS, lineterminator="\r\n")
    writer.writeheader()
    writer.writerows(rows)
    return output.getvalue().encode("utf-8")


def md(value):
    return str(value).replace("\\", "\\\\").replace("|", "\\|").replace("\r", " ").replace("\n", "<br>")


def update_table(document, heading, source_key, row, include):
    heading_match = re.search(rf"(?m)^### {re.escape(heading)}\s*$", document)
    require(heading_match is not None, f"daily log is missing heading: {heading}")
    start = heading_match.end()
    next_heading = re.search(r"(?m)^### ", document[start:])
    end = start + next_heading.start() if next_heading else len(document)
    section = document[start:end]
    marker = f"<!-- source_key={source_key} -->"
    lines = section.splitlines(keepends=True)
    existing = next((i for i, line in enumerate(lines) if marker in line), None)
    if existing is not None:
        if include:
            lines[existing] = row + "\n"
        else:
            lines.pop(existing)
    elif include:
        # Insert directly after the last table row, leaving subsequent prose intact.
        table_indices = [i for i, line in enumerate(lines) if line.startswith("|")]
        require(len(table_indices) >= 2, f"daily table is missing under: {heading}")
        lines.insert(table_indices[-1] + 1, row + "\n")
    return document[:start] + "".join(lines) + document[end:]


def update_daily(document, args, rows, timestamp, counted, cursor):
    marker = f"<!-- source_key={args.source_key} -->"
    detail = "| " + " | ".join(map(md, (
        timestamp, WEBSITE, args.platform, args.url, args.evidence,
        args.status, "是" if counted else "否", args.notes,
    ))) + f" {marker} |"
    document = update_table(document, "明细记录", args.source_key, detail, True)
    not_counted = "| " + " | ".join(map(md, (
        timestamp, WEBSITE, args.platform, args.status, "否",
        args.next_step or args.notes,
    ))) + f" {marker} |"
    document = update_table(document, "未计数/阻塞记录", args.source_key, not_counted, not counted)

    counted_rows = [
        row for row in rows
        if row["website"] == WEBSITE
        and row["last_attempted"].startswith(args.date)
        and row["last_status"].strip().lower() in COUNTED
    ]
    platforms = ", ".join(row["platform"] for row in counted_rows) or "—"
    count_pattern = rf"(?m)^\|\s*{re.escape(WEBSITE)}\s*\|[^\n]*$"
    count_row = re.search(count_pattern, document)
    require(count_row, "daily count row is missing")
    saved_goal = count_row.group().split("|")[2].strip()
    goal = args.goal if args.goal is not None else (int(saved_goal) if saved_goal.isdigit() else None)
    remaining = max(0, goal - len(counted_rows)) if goal is not None else "—"
    displayed_goal = goal if goal is not None else "未设置"
    count_line = f"| {WEBSITE} | {displayed_goal} | {len(counted_rows)} | {remaining} | {md(platforms)} |"
    document = document[:count_row.start()] + count_line + document[count_row.end():]

    current = cursor["active_csv"]
    summary = (
        f"- Active CSV: `{current}`\n"
        f"- 已处理 {cursor['active_handled_rows']} / {cursor['active_total_rows']}；"
        f"本日已计数 {len(counted_rows)}。\n"
        + (f"- Next cursor: `{cursor['next_source_key']}`（`RESUME_GATE=PASS`）。\n"
           if cursor.get("next_source_key") else "- Next cursor: 当前队列已耗尽。\n")
    )
    heading = "### 当前队列游标"
    found = re.search(r"(?m)^### 当前队列游标\s*$", document)
    if found:
        start = found.end()
        next_heading = re.search(r"(?m)^### ", document[start:])
        end = start + next_heading.start() if next_heading else len(document)
        block = document[start:end]
        for prefix, replacement in (
            ("Active CSV", summary.splitlines()[0]),
            ("已处理", summary.splitlines()[1]),
            ("Next cursor", summary.splitlines()[2]),
        ):
            pattern = rf"(?m)^- {re.escape(prefix)}[^\n]*$"
            block, count = re.subn(pattern, replacement, block, count=1)
            if count == 0:
                block = block.rstrip() + "\n" + replacement + "\n"
        document = document[:start] + block + document[end:]
    else:
        document = document.rstrip() + "\n\n" + heading + "\n\n" + summary
    return document


def stage_gate(workspace, progress_bytes, active_csv, today):
    with tempfile.TemporaryDirectory(prefix="soulpaw-record-stage-") as temporary:
        staged = Path(temporary)
        (staged / "records" / "daily").mkdir(parents=True)
        (staged / "platforms").symlink_to(workspace / "platforms", target_is_directory=True)
        for daily in (workspace / "records" / "daily").glob("*.md"):
            shutil.copy2(daily, staged / "records" / "daily" / daily.name)
        (staged / "records" / "platform-progress.csv").write_bytes(progress_bytes)
        return gate(staged, active_csv, today, allow_exhausted=True)


def atomic_write(path, data):
    fd, name = tempfile.mkstemp(prefix=f".{path.name}.", dir=path.parent)
    try:
        with os.fdopen(fd, "wb") as handle:
            handle.write(data)
            handle.flush()
            os.fsync(handle.fileno())
        os.replace(name, path)
    finally:
        if os.path.exists(name):
            os.unlink(name)


def main():
    args = parse_args()
    workspace = args.workspace.resolve()
    datetime.strptime(args.date, "%Y-%m-%d")
    require(args.goal is None or args.goal >= 0, "--goal must be nonnegative")
    timestamp = args.at or datetime.now(ZoneInfo("Asia/Shanghai")).strftime("%Y-%m-%d %H:%M")
    require(datetime.strptime(timestamp, "%Y-%m-%d %H:%M").strftime("%Y-%m-%d") == args.date,
            "--at must be on --date")
    require(all(getattr(args, field).strip() for field in ("source_key", "platform", "url", "status", "notes")),
            "source key, platform, URL, status, and notes must be nonempty")
    counted = args.status.strip().lower() in COUNTED
    require(not counted or args.state == "terminal", "counted status requires terminal state")
    require(not counted or valid_web_url(args.evidence), "counted status requires an HTTP(S) evidence URL")
    require(not args.evidence or valid_web_url(args.evidence), "evidence must be an HTTP(S) URL")
    progress_path = workspace / "records" / "platform-progress.csv"
    daily_path = workspace / "records" / "daily" / f"{args.date}.md"
    require(progress_path.is_file() and daily_path.is_file(), "progress CSV or dated daily log is missing")

    # Stable lock file: the progress file itself is replaced atomically below.
    with (workspace / "records" / ".record_outcome.lock").open("a+b") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        rows = read_progress(progress_path)
        matches = [i for i, row in enumerate(rows)
                   if row["website"] == WEBSITE and row["source_key"] == args.source_key]
        require(len(matches) <= 1, "duplicate existing source key; repair records before continuing")
        pre = gate(workspace, args.csv, args.date, allow_exhausted=True)
        if not matches:
            require(pre.get("next_source_key") == args.source_key,
                    f"out of order; next source key is {pre.get('next_source_key', 'none')}")
            require(pre.get("next_platform") == args.platform and pre.get("next_url") == args.url,
                    "platform or URL differs from the next source row")
        else:
            prior = rows[matches[0]]
            require(prior["csv"] == args.csv and prior["platform"] == args.platform and prior["platform_url"] == args.url,
                    "upsert fields differ from existing source row")

        outcome = dict(zip(HEADERS, (
            WEBSITE, args.csv, args.source_key, args.platform, args.url,
            args.state, args.status, timestamp, args.evidence, args.notes,
        )))
        if matches:
            rows[matches[0]] = outcome
        else:
            rows.append(outcome)
        progress_bytes = render_progress(rows)
        cursor = stage_gate(workspace, progress_bytes, args.csv, args.date)
        daily = update_daily(daily_path.read_text(encoding="utf-8"), args, rows, timestamp, counted, cursor)
        atomic_write(progress_path, progress_bytes)
        atomic_write(daily_path, daily.encode("utf-8"))
        # The staged gate checks the proposed progress. Recheck the actual
        # workspace after both files are durable, including the saved cursor.
        verified = gate(
            workspace, cursor["active_csv"], args.date,
            allow_exhausted=not bool(cursor.get("next_source_key")),
            expect_next=cursor.get("next_source_key"),
        )
        require(verified.get("next_source_key") == cursor.get("next_source_key"),
                "saved cursor differs from the post-write resume gate")
        print(f"recorded={args.source_key}")
        print(f"counted={'yes' if counted else 'no'}")
        print(f"active_csv={cursor['active_csv']}")
        print(f"next_source_key={cursor.get('next_source_key', 'EXHAUSTED')}")
        print("RESUME_GATE=EXHAUSTED" if verified.get("queue_exhausted") else "RESUME_GATE=PASS")


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError, csv.Error) as error:
        print(f"record_outcome: {error}", file=sys.stderr)
        sys.exit(1)

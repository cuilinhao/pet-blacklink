#!/usr/bin/env python3
"""Record an observed result on the user-authorized 2026-11-16 priority branch.

This is a local recorder, never a browser, retry-budget, or submission tool.
The dated supplemental queue is independent and requires official provenance;
platforms present in original queues must retain their original source keys.
The regular queue cursor must not move. Dry-run stages files in a temporary
directory only; it never writes the real progress CSV or daily log.
"""

import argparse
from contextlib import contextmanager
from datetime import datetime
import fcntl
import importlib.util
import json
from pathlib import Path
import re
import subprocess
from zoneinfo import ZoneInfo


WORKSPACE = Path('/Users/pgy/Documents/backlink-workspace/soul-cat')
DAY = '2026-11-16'
WEBSITE = 'Pettenderly'
ACTIVE_CSV = 'success-1104-daohang-613-final.csv'
AUDIT = WORKSPACE / 'records/runs/2026-11-16-candidate-audit.json'
SUPPLEMENTAL_CSV = 'supplemental-free-2026-11-16.csv'
SUPPLEMENTAL_AUDIT = WORKSPACE / 'records/runs/2026-11-16-supplemental-candidate-audit.json'
PRIORITIZED_REASON = (
    '用户2026-11-16本轮要求：优先免费、能直接公开的站；已经提交过的不要重复。'
    '这是明确优先分支，普通队列游标保持不变。'
)
STATUSES = ('submitted', 'pending review', 'public', 'live', 'verified',
            'scheduled', 'deferred', 'paid', 'not-relevant', 'unavailable',
            'duplicate', 'failed', 'unclear')

spec = importlib.util.spec_from_file_location(
    'priority_base_recorder', WORKSPACE / 'records/record_outcome.py')
base = importlib.util.module_from_spec(spec)
spec.loader.exec_module(base)


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--workspace', type=Path, default=WORKSPACE)
    parser.add_argument('--website', default=WEBSITE)
    parser.add_argument('--date', default=DAY)
    parser.add_argument('--csv', default=ACTIVE_CSV)
    parser.add_argument('--source-key', required=True)
    parser.add_argument('--platform', required=True)
    parser.add_argument('--url', required=True, help='Exact original CSV URL')
    parser.add_argument('--status', choices=STATUSES, required=True)
    parser.add_argument('--state', choices=('terminal', 'deferred'), required=True)
    parser.add_argument('--evidence', default='')
    parser.add_argument('--evidence-artifact', type=Path,
                        help='Existing local receipt/evidence file; required for counted outcomes')
    parser.add_argument('--notes', required=True, help='Observed result only; no credentials')
    parser.add_argument('--next-step')
    parser.add_argument('--at', help='Asia/Shanghai timestamp on 2026-11-16')
    parser.add_argument('--goal', type=int, default=21)
    parser.add_argument('--dry-run', action='store_true')
    return parser.parse_args()


def canonical_history_check(source_key, candidate_csv=ACTIVE_CSV):
    """Use the unchanged gate's own queue parsing/normalization functions."""
    ruby = r'''
require 'json'
request = JSON.parse(STDIN.read)
gate = request.fetch('gate')
ARGV.replace(['--workspace', request.fetch('workspace'), '--website', 'Pettenderly',
              '--active-csv', 'success-1104-daohang-613-final.csv', '--today', '2026-11-16'])
source = File.read(gate)
raise 'gate exit signature changed' unless source.match?(/exit\(errors\.empty\? \? 0 : 2\)\s*\z/)
context = binding
eval(source.sub(/exit\(errors\.empty\? \? 0 : 2\)\s*\z/, ''), context, gate)
raise 'canonical gate failed' unless context.local_variable_get(:errors).empty?
queue_candidates = context.local_variable_get(:active_candidates)
if request.fetch('candidate_csv') != 'success-1104-daohang-613-final.csv'
  mode, queue_candidates = load_active_queue(File.join(request.fetch('workspace'), 'platforms', request.fetch('candidate_csv')))
  raise 'supplemental queue must use standard platform identities' unless mode == 'standard-platform'
end
candidates = queue_candidates.select { |c| c[:source_key] == request.fetch('source_key') }
raise 'candidate missing or duplicated in actual CSV' unless candidates.length == 1
candidate = candidates.first
matches = context.local_variable_get(:progress_rows).select do |row|
  row['source_key'] == candidate[:source_key] ||
    related_identity?(platform_identity(row['platform_url']), candidate[:identity]) ||
    normalized_name(row['platform']) == candidate[:name]
end
daily = context.local_variable_get(:daily_history).select do |entry|
  related_identity?(entry[:identity], candidate[:identity]) || entry[:name] == candidate[:name]
end
other_queue_matches = []
if request.fetch('candidate_csv') != 'success-1104-daohang-613-final.csv'
  request.fetch('original_csvs').each do |basename|
    path = File.join(request.fetch('workspace'), 'platforms', basename)
    # One legacy CSV has malformed quoting. Check every original byte as text
    # conservatively rather than skipping that file or rewriting its source.
    text = normalized_name(File.read(path, encoding: 'bom|utf-8'))
    identifiers = [candidate[:name], normalized_name(candidate[:identity])].reject(&:empty?)
    if identifiers.any? { |identity| text.include?(identity) }
      other_queue_matches << {csv: basename, candidate: candidate[:platform],
                              reason: 'conservative normalized name/domain match'}
    end
  end
end
puts 'PRIORITY_AUDIT_JSON=' + JSON.generate({candidate: candidate,
  progress: matches.map(&:to_h), counted_daily_matches: daily.length,
  other_queue_matches: other_queue_matches})
'''
    result = subprocess.run(
        [base.RUBY, '-e', ruby], input=json.dumps({
            'gate': str(base.GATE), 'workspace': str(WORKSPACE), 'source_key': source_key,
            'candidate_csv': candidate_csv,
            'original_csvs': base.ALLOWED_CSVS,
        }), text=True, capture_output=True)
    base.require(result.returncode == 0,
                 'canonical candidate/history check failed: ' + result.stderr.strip())
    lines = [line.split('=', 1)[1] for line in result.stdout.splitlines()
             if line.startswith('PRIORITY_AUDIT_JSON=')]
    base.require(len(lines) == 1, 'canonical candidate/history response missing')
    return json.loads(lines[0])


@contextmanager
def record_lock(dry_run):
    path = WORKSPACE / 'records/.record_outcome.lock'
    # No real-file creation during validation. Normal writes share the original lock.
    mode = 'rb' if dry_run else 'a+b'
    with path.open(mode) as handle:
        fcntl.flock(handle, fcntl.LOCK_EX)
        yield


def main():
    args = parse_args()
    base.require(args.workspace.resolve() == WORKSPACE, 'wrong workspace')
    base.require(args.website == WEBSITE, 'wrong website')
    base.require(args.date == DAY, 'this recorder is restricted to 2026-11-16')
    base.require(args.csv in (ACTIVE_CSV, SUPPLEMENTAL_CSV), 'wrong candidate CSV')
    base.require(args.goal == 21, 'this run goal is fixed at 21 (Neeed plus 20 new submissions)')
    timestamp = args.at or datetime.now(ZoneInfo('Asia/Shanghai')).strftime('%Y-%m-%d %H:%M')
    base.require(datetime.strptime(timestamp, '%Y-%m-%d %H:%M').strftime('%Y-%m-%d') == DAY,
                 '--at/current date must be 2026-11-16')
    base.require(all(getattr(args, field).strip() for field in
                     ('source_key', 'platform', 'url', 'status', 'notes')), 'empty required field')
    counted = args.status in base.COUNTED
    base.require(not counted or args.state == 'terminal', 'counted status requires terminal state')
    base.require(not args.evidence or base.valid_web_url(args.evidence), 'invalid evidence URL')
    base.require(not counted or base.valid_web_url(args.evidence), 'counted outcome needs HTTP(S) receipt URL')
    base.require(not counted or args.evidence_artifact is not None,
                 'counted outcome needs an existing local receipt/evidence artifact')
    if args.evidence_artifact:
        artifact = args.evidence_artifact.resolve()
        base.require(artifact.is_file() and artifact.is_relative_to(WORKSPACE / 'records'),
                     'evidence artifact must be an existing file under workspace records')
        base.require('account-credentials' not in str(artifact), 'credentials are not evidence')

    audit_path = AUDIT if args.csv == ACTIVE_CSV else SUPPLEMENTAL_AUDIT
    audit = json.loads(audit_path.read_text())
    base.require(audit['website'] == WEBSITE and audit['requested_date'] == DAY, 'wrong audit scope')
    candidates = audit.get('unprocessed_candidates_at_audit', audit.get('next_30_unprocessed', []))
    approved = [item for item in candidates if item['source_key'] == args.source_key]
    base.require(len(approved) == 1, 'candidate not in this run audited eligible set')
    approved = approved[0]
    base.require(approved['platform'] == args.platform and approved['url'] == args.url,
                 'platform/URL differs from audited original CSV row')
    if args.csv == SUPPLEMENTAL_CSV:
        base.require(audit.get('csv') == SUPPLEMENTAL_CSV, 'wrong supplemental audit CSV')
        base.require(approved.get('free_evidence') and approved.get('official_sources')
                     and all(base.valid_web_url(url) for url in approved['official_sources']),
                     'supplemental candidate needs official free-submission provenance')

    progress_path = WORKSPACE / 'records/platform-progress.csv'
    daily_path = WORKSPACE / 'records/daily' / f'{DAY}.md'
    base.require(progress_path.is_file() and daily_path.is_file(), 'progress/daily log missing')
    with record_lock(args.dry_run):
        rows = base.read_progress(progress_path)
        pre = base.gate(WORKSPACE, ACTIVE_CSV, DAY)
        history = canonical_history_check(args.source_key, args.csv)
        actual = history['candidate']
        base.require(actual['platform'] == args.platform and actual['url'] == args.url
                     and actual['identity'] == approved['identity'],
                     'candidate identity differs from actual CSV row')
        base.require(history['counted_daily_matches'] == 0, 'platform already counted in daily history')
        base.require(not history['other_queue_matches'],
                     'supplemental platform already exists in an original CSV; use its original source key')
        matches = history['progress']
        base.require(len(matches) <= 1, 'same platform has another progress record')
        if matches:
            prior = matches[0]
            base.require(prior['source_key'] == args.source_key
                         and prior['last_attempted'].startswith(DAY)
                         and prior['notes'].startswith('[priority-20261116]'),
                         'historical/other-run platform is not eligible for this new branch')
            base.require(prior['last_status'].lower() not in base.COUNTED,
                         'already submitted/counted; no repeat allowed')
            base.require(prior['state'] != 'deferred'
                         and not re.search(r'unknown|unclear|draft|resume|未知|草稿|续跑',
                                           prior['notes'] + ' ' + prior['last_status'], re.I),
                         'deferred/unknown/draft checkpoints require a separate safe resume flow')
            base.require(prior['csv'] == args.csv and prior['platform'] == args.platform
                         and prior['platform_url'] == args.url, 'existing original fields changed')

        observed_notes = args.notes
        args.notes = '[priority-20261116] prioritized_reason=' + PRIORITIZED_REASON + ' Observed: ' + observed_notes
        if args.evidence_artifact:
            args.notes += ' Artifact: ' + str(args.evidence_artifact.resolve().relative_to(WORKSPACE))
        outcome = dict(zip(base.HEADERS, (
            WEBSITE, args.csv, args.source_key, args.platform, args.url,
            args.state, args.status, timestamp, args.evidence, args.notes,
        )))
        indices = [i for i, row in enumerate(rows)
                   if row['website'] == WEBSITE and row['source_key'] == args.source_key]
        base.require(len(indices) <= 1, 'duplicate source key')
        if indices:
            rows[indices[0]] = outcome
        else:
            rows.append(outcome)
        progress_bytes = base.render_progress(rows)
        cursor = base.stage_gate(WORKSPACE, progress_bytes, ACTIVE_CSV, DAY)
        base.require(cursor.get('next_source_key') == pre.get('next_source_key'),
                     'priority branch would move ordinary cursor; use original recorder for that row')
        daily = base.update_daily(daily_path.read_text(), args, rows, timestamp, counted, cursor)
        additional_count = sum(
            row['website'] == WEBSITE and row['last_attempted'].startswith(DAY)
            and row['last_status'].lower() in base.COUNTED
            and row['source_key'] != ACTIVE_CSV + '::neeed.directory::neeed.directory'
            for row in rows)
        daily = re.sub(r'本次新增 20 个当前完成 \d+ 个',
                       f'本次新增 20 个当前完成 {additional_count} 个', daily)
        if not args.dry_run:
            base.atomic_write(progress_path, progress_bytes)
            base.atomic_write(daily_path, daily.encode('utf-8'))
            base.gate(WORKSPACE, ACTIVE_CSV, DAY, expect_next=pre['next_source_key'])
        print(json.dumps({
            'dry_run': args.dry_run, 'recorded': not args.dry_run,
            'source_key': args.source_key, 'counted': counted,
            'prioritized_reason': PRIORITIZED_REASON,
            'ordinary_next_source_key': pre['next_source_key'],
            'staged_gate': 'PASS', 'browser_or_checkpoint_actions': False,
        }, ensure_ascii=False))


if __name__ == '__main__':
    try:
        main()
    except (ValueError, OSError, KeyError, json.JSONDecodeError) as error:
        raise SystemExit(f'priority_recorder: {error}')

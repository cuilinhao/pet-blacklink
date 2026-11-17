#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "open3"
require "rbconfig"
require "tmpdir"

GATE = File.expand_path("resume_gate.rb", __dir__)
PROGRESS_HEADER = "website,csv,source_key,platform,platform_url,state,last_status,last_attempted,evidence_url,notes\n"

def assert(condition, message)
  raise message unless condition
end

def run_gate(workspace, active_csv, *extra)
  Open3.capture3(
    RbConfig.ruby,
    GATE,
    "--workspace", workspace,
    "--website", "ExampleSite",
    "--active-csv", active_csv,
    "--today", "2026-08-15",
    *extra
  )
end

Dir.mktmpdir("backlink-resume-gate-test-") do |workspace|
  FileUtils.mkdir_p(File.join(workspace, "platforms"))
  FileUtils.mkdir_p(File.join(workspace, "records", "daily"))
  progress_path = File.join(workspace, "records", "platform-progress.csv")
  File.write(progress_path, PROGRESS_HEADER)

  sample_csv = File.join(workspace, "platforms", "gefei0810.csv")
  File.write(
    sample_csv,
    "表格 1\n" \
      "Type,URL,Discovered From,Has Captcha,Link Strategy,Link Format,Has URL Field\n" \
      "blog_comment,https://example.com/article-a?utm_source=test,ahrefs:source.test,No,url_field,html,Yes\n" \
      "blog_comment,https://example.com/article-b?id=2,ahrefs:source.test,Yes,both,bbcode,No\n"
  )

  stdout, stderr, status = run_gate(workspace, "gefei0810.csv")
  assert(status.success?, "sample queue should pass: #{stderr}")
  assert(stdout.include?("queue_mode=backlink-sample"), "sample queue mode missing")
  assert(stdout.include?("active_total_rows=2"), "sample row count is wrong")
  assert(
    stdout.include?("next_source_key=gefei0810.csv::blog_comment::example.com/article-a"),
    "optional title row or tracking-query normalization failed"
  )
  assert(stdout.include?("next_link_format=html"), "sample metadata output missing")

  # Git checkout and atomic writes can leave mixed LF/CRLF on Windows.
  original_queue = File.binread(sample_csv)
  File.binwrite(sample_csv, original_queue.gsub(/\r?\n/, "\n").sub("\n", "\r\n"))
  File.binwrite(progress_path, PROGRESS_HEADER.sub("\n", "\r\n"))
  stdout, stderr, status = run_gate(workspace, "gefei0810.csv")
  assert(status.success?, "mixed Windows line endings should pass: #{stderr}")
  assert(stdout.include?("active_total_rows=2"), "mixed line endings changed queue rows")
  File.binwrite(sample_csv, original_queue)

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,gefei0810.csv,gefei0810.csv::blog_comment::example.com/article-a,example.com,https://example.com/article-a?utm_source=test,terminal,comments-closed,2026-08-15 09:00,,first row handled\n"
  )
  stdout, stderr, status = run_gate(workspace, "gefei0810.csv")
  assert(status.success?, "second sample page should remain actionable: #{stderr}")
  assert(stdout.include?("active_handled_rows=1"), "handled sample row count is wrong")
  assert(
    stdout.include?("next_source_key=gefei0810.csv::blog_comment::example.com/article-b?id=2"),
    "same-domain target pages were incorrectly collapsed"
  )

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,gefei0810.csv,gefei0810.csv::blog_comment::example.com/article-a,example.com,https://example.com/article-a?utm_source=test,deferred,comment-pending-moderation,2026-08-14 09:00,,awaiting moderation\n"
  )
  stdout, stderr, status = run_gate(workspace, "gefei0810.csv", "--retry-deferred")
  assert(status.success?, "pending sample comment should be retryable: #{stderr}")
  assert(
    stdout.include?("next_source_key=gefei0810.csv::blog_comment::example.com/article-a"),
    "pending moderation was incorrectly treated as counted"
  )

  unknown_csv = File.join(workspace, "platforms", "unknown-types.csv")
  File.write(
    unknown_csv,
    "Type,URL\n" \
      "directory_listing,https://first.example.com/submit\n" \
      "unknown,https://unclassified.example.org/tool\n" \
      ",https://blanktype.example.net/page\n" \
      "unknown,\n"
  )
  File.write(progress_path, PROGRESS_HEADER)
  stdout, stderr, status = run_gate(workspace, "unknown-types.csv")
  assert(status.success?, "unknown-type queue should remain inspectable: #{stderr}")
  assert(stdout.include?("active_total_rows=3"), "unknown/blank types with URLs must be retained, empty URLs excluded")
  assert(
    stdout.include?("next_source_key=unknown-types.csv::directory_listing::first.example.com/submit"),
    "including unknown types must preserve source order"
  )
  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,unknown-types.csv,unknown-types.csv::directory_listing::first.example.com/submit,first.example.com,https://first.example.com/submit,terminal,paid,2026-08-15 09:00,,handled\n"
  )
  stdout, stderr, status = run_gate(workspace, "unknown-types.csv")
  assert(status.success?, "unknown type must get a real disposition instead of silent exclusion: #{stderr}")
  assert(
    stdout.include?("next_source_key=unknown-types.csv::unknown::unclassified.example.org/tool"),
    "unknown source hint must be preserved in the source key"
  )
  assert(stdout.include?("next_row_type=unknown"), "runtime classification must see the original unknown hint")
  File.open(progress_path, "a") do |file|
    file.write("ExampleSite,unknown-types.csv,unknown-types.csv::unknown::unclassified.example.org/tool,unclassified.example.org,https://unclassified.example.org/tool,terminal,unsupported-page,2026-08-15 09:01,,visibly unsupported\n")
  end
  stdout, stderr, status = run_gate(workspace, "unknown-types.csv")
  assert(status.success?, "blank-type URL should remain after the unknown row is handled: #{stderr}")
  assert(
    stdout.include?("next_source_key=unknown-types.csv::unknown::blanktype.example.net/page"),
    "blank hint must normalize to unknown without dropping the URL"
  )

  legacy_csv = File.join(workspace, "platforms", "legacy.csv")
  File.write(
    legacy_csv,
    "平台名称,提交入口/网址\n" \
      "Platform A,https://legacy.example.com/submit\n" \
      "Platform B,https://other.example.org/add\n"
  )
  File.write(progress_path, PROGRESS_HEADER)
  stdout, stderr, status = run_gate(workspace, "legacy.csv")
  assert(status.success?, "legacy queue should pass: #{stderr}")
  assert(stdout.include?("queue_mode=standard-platform"), "legacy queue mode changed")
  assert(
    stdout.include?("next_source_key=legacy.csv::Platform A::example.com"),
    "registrable-domain source key was not used"
  )

  catalog_csv = File.join(workspace, "platforms", "xiaoerduo_0820.csv")
  File.write(
    catalog_csv,
    "名称/网址,流量,最低价,付费/免费,类型\n" \
      "https://news.ycombinator.com/news,11.9M,,免费,论坛\n" \
      "toolifiy,,,,发布平台\n"
  )
  File.write(progress_path, PROGRESS_HEADER)
  stdout, stderr, status = run_gate(workspace, "xiaoerduo_0820.csv")
  assert(status.success?, "catalog queue should pass: #{stderr}")
  assert(stdout.include?("queue_mode=catalog-platform"), "catalog queue mode missing")
  assert(stdout.include?("active_total_rows=2"), "catalog row count is wrong")
  assert(
    stdout.include?("next_source_key=xiaoerduo_0820.csv::news.ycombinator.com::ycombinator.com"),
    "catalog source key was not normalized"
  )
  assert(stdout.include?("next_traffic=11.9M"), "catalog traffic metadata missing")
  assert(stdout.include?("next_access_model=免费"), "catalog access metadata missing")
  assert(stdout.include?("next_platform_type=论坛"), "catalog type metadata missing")

  lxx_csv = File.join(workspace, "platforms", "lxx-blacklink.csv")
  File.write(
    lxx_csv,
    "Free/Paid,Link,Type,Link Type,Category,DR,Traffic,Update Date,Language\n" \
      "Free Submission,https://aiai.tools/,Text Link,Nofollow,AI Tools Directory,31,667,2025-11-03,English\n" \
      "Paid Submission,https://paid.example.com/,Text Link,Dofollow,General,50,1200,2025-11-03,English\n"
  )
  File.write(progress_path, PROGRESS_HEADER)
  stdout, stderr, status = run_gate(workspace, "lxx-blacklink.csv")
  assert(status.success?, "lxx catalog queue should pass: #{stderr}")
  assert(stdout.include?("queue_mode=catalog-platform"), "lxx queue mode missing")
  assert(stdout.include?("active_total_rows=2"), "lxx row count is wrong")
  assert(
    stdout.include?("next_source_key=lxx-blacklink.csv::aiai.tools::aiai.tools"),
    "lxx source key was not normalized"
  )
  assert(stdout.include?("next_traffic=667"), "lxx traffic metadata missing")
  assert(stdout.include?("next_access_model=Free Submission"), "lxx access metadata missing")
  assert(stdout.include?("next_platform_type=AI Tools Directory"), "lxx category metadata missing")

  cross_mode_sample_csv = File.join(workspace, "platforms", "cross-mode-sample.csv")
  File.write(
    cross_mode_sample_csv,
    "Type,URL,Discovered From,Has Captcha,Link Strategy,Link Format,Has URL Field\n" \
      "profile,https://market.example.net/missing-sample,ahrefs:source.test,No,url_field,html,Yes\n"
  )
  cross_mode_catalog_csv = File.join(workspace, "platforms", "cross-mode-catalog.csv")
  File.write(
    cross_mode_catalog_csv,
    "名称/网址,流量,最低价,付费/免费,类型\n" \
      "https://market.example.net/add-product,10k,,免费,发布平台\n"
  )
  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,cross-mode-sample.csv,cross-mode-sample.csv::profile::example.net/missing-sample,example.net,https://market.example.net/missing-sample,terminal,sample-page-not-found,2026-08-14 09:00,,unrelated sample page failed\n"
  )
  stdout, stderr, status = run_gate(workspace, "cross-mode-catalog.csv")
  assert(status.success?, "an uncounted backlink-sample page must not block an official catalog route: #{stderr}")
  assert(
    stdout.include?("next_source_key=cross-mode-catalog.csv::market.example.net::example.net"),
    "uncounted cross-mode sample history incorrectly collapsed the catalog platform"
  )

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,cross-mode-sample.csv,cross-mode-sample.csv::profile::example.net/missing-sample,example.net,https://market.example.net/missing-sample,terminal,profile-public,2026-08-14 09:00,https://market.example.net/profile/example,successful sample placement\n"
  )
  stdout, stderr, status = run_gate(workspace, "cross-mode-catalog.csv")
  assert(!status.success?, "a counted backlink-sample placement must still deduplicate the catalog domain")
  assert(stdout.include?("active_handled_rows=1"), "counted cross-mode placement did not block the catalog platform")

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,old-platforms.csv,old-platforms.csv::Market::example.net,Market,https://market.example.net/add-product,deferred,oauth-confirmation-required,2026-08-13 09:00,,official platform checkpoint\n" +
      "ExampleSite,cross-mode-sample.csv,cross-mode-sample.csv::profile::example.net/missing-sample,example.net,https://market.example.net/missing-sample,terminal,sample-page-not-found,2026-08-14 09:00,,newer unrelated sample failure\n"
  )
  stdout, stderr, status = run_gate(workspace, "cross-mode-catalog.csv", "--retry-unresolved")
  assert(status.success?, "a newer uncounted sample failure must not hide an older retryable platform checkpoint: #{stderr}")
  assert(
    stdout.include?("next_retry_origin_status=oauth-confirmation-required"),
    "retry mode selected the unrelated sample result instead of the platform checkpoint"
  )

  retry_catalog_csv = File.join(workspace, "platforms", "retry-catalog.csv")
  File.write(
    retry_catalog_csv,
    "名称/网址,流量,最低价,付费/免费,类型\n" \
      "https://retry.example.com/,10k,,免费,发布平台\n" \
      "https://paid.example.org/,20k,,付费,发布平台\n" \
      "https://submitted.example.net/,30k,,免费,发布平台\n" \
      "https://legal.example.dev/,40k,,免费,发布平台\n" \
      "https://social.example.app/,50k,,免费,社交\n"
  )
  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,old.csv,old.csv::Retry::example.com,Retry,https://retry.example.com/submit,terminal,failed-unavailable,2026-08-14 09:00,,temporary outage\n" +
      "ExampleSite,old.csv,old.csv::Paid::example.org,Paid,https://paid.example.org/submit,terminal,paid-only,2026-08-14 09:00,,paid route\n" +
      "ExampleSite,old.csv,old.csv::Submitted::example.net,Submitted,https://submitted.example.net/add,terminal,submitted-pending-review,2026-08-14 09:00,https://submitted.example.net/receipt,already sent\n" +
      "ExampleSite,old.csv,old.csv::Legal::example.dev,Legal,https://legal.example.dev/add,deferred,legal-and-oauth-confirmation-required,2026-08-14 09:00,,resumable confirmation\n" +
      "ExampleSite,old.csv,old.csv::Social::example.app,Social,https://social.example.app/,terminal,no-direct-submission-social-account-unavailable,2026-08-14 09:00,,no listing route\n"
  )
  stdout, stderr, status = run_gate(workspace, "retry-catalog.csv", "--retry-unresolved")
  assert(status.success?, "unresolved catalog retry should pass: #{stderr}")
  assert(stdout.include?("retry_mode=unresolved"), "unresolved retry mode missing")
  assert(stdout.include?("active_remaining_rows=2"), "retry filters selected the wrong number of candidates")
  assert(
    stdout.include?("next_source_key=retry-catalog.csv::retry.example.com::example.com"),
    "retry mode did not preserve catalog source order"
  )
  assert(stdout.include?("next_retry_origin_status=failed-unavailable"), "retry origin status missing")

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,xiaoerduo_0820.csv,xiaoerduo_0820.csv::news.ycombinator.com::ycombinator.com,news.ycombinator.com,https://news.ycombinator.com/news,terminal,not-relevant,2026-08-15 09:00,,forum row handled\n"
  )
  stdout, stderr, status = run_gate(workspace, "xiaoerduo_0820.csv")
  assert(status.success?, "plain-name catalog row should remain actionable: #{stderr}")
  assert(
    stdout.include?("next_source_key=xiaoerduo_0820.csv::toolifiy::toolifiy"),
    "plain catalog label was not preserved deterministically"
  )

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,legacy.csv,legacy.csv::Platform A::audit.example.com,Platform A,https://audit.example.com/report,terminal,submitted,2026-08-14 09:00,https://audit.example.com/report,sibling subdomain handled\n"
  )
  stdout, stderr, status = run_gate(workspace, "legacy.csv")
  assert(status.success?, "sibling subdomain history should pass: #{stderr}")
  assert(stdout.include?("active_handled_rows=1"), "sibling subdomains were not collapsed")
  assert(
    stdout.include?("next_source_key=legacy.csv::Platform B::example.org"),
    "different registrable domain was incorrectly collapsed"
  )

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,old.csv,old.csv::Platform A::example.com,Platform A,https://example.com/submit,deferred,badge-required,2026-08-14 09:00,,older incomplete draft\n" +
      "ExampleSite,legacy.csv,legacy.csv::Platform A::example.com,Platform A,https://example.com/listing,terminal,live,2026-08-15 09:00,https://example.com/listing,first completed placement\n"
  )
  stdout, stderr, status = run_gate(workspace, "legacy.csv")
  assert(status.success?, "an older uncounted checkpoint must not invalidate today's first completion: #{stderr}")

  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,old.csv,old.csv::Platform A::example.com,Platform A,https://example.com/submit,terminal,live,2026-08-14 09:00,https://example.com/old-listing,older counted placement\n" +
      "ExampleSite,legacy.csv,legacy.csv::Platform A::example.com,Platform A,https://example.com/listing,terminal,live,2026-08-15 09:00,https://example.com/listing,repeat placement\n"
  )
  stdout, stderr, status = run_gate(workspace, "legacy.csv")
  assert(!status.success?, "an older counted placement must still reject today's duplicate")
  assert(stderr.include?("today counted duplicate"), "counted duplicate diagnostic missing")

  public_suffix_csv = File.join(workspace, "platforms", "public-suffix.csv")
  File.write(
    public_suffix_csv,
    "平台名称,提交入口/网址\n" \
      "UK Platform,https://submit.example.co.uk/add\n" \
      "Other UK Platform,https://submit.example.org.uk/add\n"
  )
  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,public-suffix.csv,public-suffix.csv::UK Platform::audit.example.co.uk,UK Platform,https://audit.example.co.uk/report,terminal,submitted,2026-08-14 09:00,https://audit.example.co.uk/report,co.uk sibling handled\n"
  )
  stdout, stderr, status = run_gate(workspace, "public-suffix.csv")
  assert(status.success?, "public suffix queue should pass: #{stderr}")
  assert(stdout.include?("active_handled_rows=1"), "co.uk sibling subdomains were not collapsed")
  assert(
    stdout.include?("next_source_key=public-suffix.csv::Other UK Platform::example.org.uk"),
    "different co.uk registrable domains were incorrectly collapsed"
  )

  shared_host_csv = File.join(workspace, "platforms", "shared-host.csv")
  File.write(
    shared_host_csv,
    "平台名称,提交入口/网址\n" \
      "Google Form A,https://docs.google.com/forms/d/e/form-a/viewform\n" \
      "Google Form B,https://docs.google.com/forms/d/e/form-b/viewform\n"
  )
  File.write(
    progress_path,
    PROGRESS_HEADER +
      "ExampleSite,shared-host.csv,shared-host.csv::Google Form A::docs.google.com/forms/d/e/form-a/viewform,Google Form A,https://docs.google.com/forms/d/e/form-a/viewform,terminal,submitted,2026-08-14 09:00,https://docs.google.com/forms/d/e/form-a/viewform,first hosted path handled\n"
  )
  stdout, stderr, status = run_gate(workspace, "shared-host.csv")
  assert(status.success?, "shared-host queue should pass: #{stderr}")
  assert(stdout.include?("active_handled_rows=1"), "handled shared-host path was not recognized")
  assert(
    stdout.include?("next_source_key=shared-host.csv::Google Form B::docs.google.com/forms/d/e/form-b/viewform"),
    "distinct shared-host paths were incorrectly collapsed"
  )

  File.write(
    progress_path,
    "date,platform_name,domain,entry_url,status,counted,public_url,evidence_path,reason,next_cursor\n" \
      "2026-08-14,Platform A,audit.example.com,https://audit.example.com/report,terminal,no,,records/evidence/platform-a.txt,legacy row handled,legacy.csv:row2\n"
  )
  stdout, stderr, status = run_gate(workspace, "legacy.csv")
  assert(status.success?, "legacy progress schema should be read-only compatible: #{stderr}")
  assert(stdout.include?("progress_schema=legacy-readonly"), "legacy progress schema was not detected")
  assert(stdout.include?("progress_rows=1"), "legacy progress row was not loaded")
  assert(stdout.include?("active_handled_rows=1"), "legacy progress identity did not affect deduplication")
  assert(
    stdout.include?("next_source_key=legacy.csv::Platform B::example.org"),
    "legacy progress compatibility selected the wrong next candidate"
  )
end

puts "resume_gate tests: PASS"

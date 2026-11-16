#!/usr/bin/env ruby
# frozen_string_literal: true

require "csv"
require "date"
require "optparse"
require "public_suffix"
require "uri"

COUNTED_STATUSES = [
  "submitted",
  "submitted-pending-review",
  "pending review",
  "public",
  "public-counted",
  "public-listed",
  "live",
  "verified",
  "scheduled"
].freeze

BACKLINK_SAMPLE_COUNTED_STATUSES = [
  "public",
  "live",
  "verified",
  "comment-live",
  "profile-public",
  "forum-reply-live",
  "community-post-live",
  "product-listing-public",
  "backlink-public"
].freeze

RETRYABLE_UNRESOLVED_STATUS_PATTERNS = [
  /failed-unavailable/,
  /oauth/,
  /account/,
  /legal/,
  /confirmation/,
  /human-verification/,
  /captcha/,
  /cloudflare/,
  /computer-use/,
  /browser-security/,
  /credential/,
  /password/,
  /badge/,
  /authentication-handler-broken/,
  /restricted/
].freeze

NON_RETRYABLE_STATUS_PATTERNS = [
  /\Apaid\z/,
  /paid-only/,
  /paid-without-approval/,
  /blacklisted/,
  /not-relevant/,
  /ineligible/,
  /duplicate/,
  /submitted/,
  /submission-received/,
  /public/,
  /listed/,
  /live/,
  /verified/,
  /scheduled/,
  /thin-content/,
  /prohibits-ai/,
  /unowned/,
  /no-direct-submission/,
  /no-product-listing/,
  /no-directory-submission/,
  /no-approved/,
  /sample-page-not-found/,
  /site-builder/,
  /missing-contact-company-facts/,
  /spam/
].freeze

TRACKING_QUERY_KEYS = %w[
  fbclid
  gclid
  mc_cid
  mc_eid
].freeze

SHARED_HOSTS = %w[
  docs.google.com
  forms.gle
  github.com
  tally.so
].freeze

CANONICAL_PROGRESS_HEADERS = %w[
  website
  csv
  source_key
  platform
  platform_url
  state
  last_status
  last_attempted
  evidence_url
  notes
].freeze

LEGACY_PROGRESS_HEADERS = %w[
  date
  platform_name
  domain
  entry_url
  status
  counted
  public_url
  evidence_path
  reason
  next_cursor
].freeze

options = {
  workspace: File.expand_path("../../..", __dir__),
  today: Date.today.to_s
}

OptionParser.new do |parser|
  parser.banner = "Usage: resume_gate.rb --website NAME --active-csv FILE [options]"
  parser.on("--workspace PATH", "Backlink workspace root") { |value| options[:workspace] = File.expand_path(value) }
  parser.on("--website NAME", "Target website name") { |value| options[:website] = value }
  parser.on("--active-csv FILE", "Active CSV filename or absolute path") { |value| options[:active_csv] = value }
  parser.on("--today YYYY-MM-DD", "Run date used for duplicate-count audit") { |value| options[:today] = value }
  parser.on("--expect-next-source-key KEY", "Fail unless the reconciled cursor matches KEY") do |value|
    options[:expect_next_source_key] = value
  end
  parser.on("--retry-source-key KEY", "Explicitly reopen one persisted deferred row for a user-authorized retry pass") do |value|
    options[:retry_source_key] = value
  end
  parser.on("--retry-deferred", "Select the first deferred row in CSV order that has not been retried today") do
    options[:retry_deferred] = true
  end
  parser.on("--retry-unresolved", "Re-audit catalog platforms whose latest historical outcome is safely retryable and has never counted") do
    options[:retry_unresolved] = true
  end
end.parse!

abort "missing --website" if options[:website].to_s.empty?
abort "missing --active-csv" if options[:active_csv].to_s.empty?
retry_modes = [options[:retry_source_key], options[:retry_deferred], options[:retry_unresolved]].compact
abort "use only one retry mode" if retry_modes.length > 1

workspace = options[:workspace]
progress_path = File.join(workspace, "records", "platform-progress.csv")
daily_dir = File.join(workspace, "records", "daily")
active_csv_path =
  if File.absolute_path(options[:active_csv]) == options[:active_csv]
    options[:active_csv]
  else
    File.join(workspace, "platforms", options[:active_csv])
  end

abort "missing progress CSV: #{progress_path}" unless File.file?(progress_path)
abort "missing active CSV: #{active_csv_path}" unless File.file?(active_csv_path)

def normalized_host(value)
  raw = value.to_s.strip
  return nil if raw.empty?

  raw = "https://#{raw}" unless raw.match?(%r{\A[a-z][a-z0-9+.-]*://}i)
  host = URI.parse(raw).host&.downcase
  host&.sub(/\Awww\./, "")
rescue URI::InvalidURIError
  nil
end

def normalized_path(value)
  raw = value.to_s.strip
  return "/" if raw.empty?

  raw = "https://#{raw}" unless raw.match?(%r{\A[a-z][a-z0-9+.-]*://}i)
  path = URI.parse(raw).path.to_s.gsub(%r{/+}, "/")
  path = "/" if path.empty?
  path.sub(%r{/\z}, "").then { |result| result.empty? ? "/" : result }
rescue URI::InvalidURIError
  "/"
end

def normalized_name(value)
  value.to_s.downcase.gsub(/[^\p{Alnum}]+/u, "")
end

def shared_host?(host)
  SHARED_HOSTS.include?(host)
end

def registrable_domain(host)
  PublicSuffix.domain(host)
rescue PublicSuffix::Error
  host
end

def platform_identity(url)
  host = normalized_host(url)
  return nil unless host

  shared_host?(host) ? "#{host}#{normalized_path(url)}" : registrable_domain(host)
end

def load_progress_rows(progress_path, website)
  table = CSV.read(progress_path, headers: true, encoding: "bom|utf-8")
  headers = table.headers.compact

  if (CANONICAL_PROGRESS_HEADERS - headers).empty?
    return ["canonical", table.select { |row| row["website"] == website }]
  end

  unless (LEGACY_PROGRESS_HEADERS - headers).empty?
    abort "unsupported progress CSV headers: #{headers.join(', ')}"
  end

  rows = table.each_with_index.map do |row, index|
    platform = row["platform_name"].to_s.strip
    platform_url = row["entry_url"].to_s.strip
    platform_url = row["domain"].to_s.strip if platform_url.empty?
    identity = platform_identity(platform_url) || normalized_name(platform)
    status = row["status"].to_s.strip
    notes = [
      row["reason"].to_s.strip,
      ("evidence=#{row['evidence_path'].to_s.strip}" unless row["evidence_path"].to_s.strip.empty?),
      ("legacy_next_cursor=#{row['next_cursor'].to_s.strip}" unless row["next_cursor"].to_s.strip.empty?)
    ].compact.reject(&:empty?).join("; ")

    {
      "website" => website,
      "csv" => "legacy-progress.csv",
      "source_key" => "legacy-progress.csv::#{index + 1}::#{platform}::#{identity}",
      "platform" => platform,
      "platform_url" => platform_url,
      "state" => status == "deferred" ? "deferred" : "terminal",
      "last_status" => status,
      "last_attempted" => row["date"].to_s.strip,
      "evidence_url" => row["public_url"].to_s.strip,
      "notes" => notes
    }
  end

  ["legacy-readonly", rows]
end

def target_page_identity(value)
  raw = value.to_s.strip
  return nil if raw.empty?

  raw = "https://#{raw}" unless raw.match?(%r{\A[a-z][a-z0-9+.-]*://}i)
  uri = URI.parse(raw)
  host = uri.host&.downcase&.sub(/\Awww\./, "")
  return nil unless host

  path = uri.path.to_s.gsub(%r{/+}, "/")
  path = "/" if path.empty?
  path = path.sub(%r{/\z}, "")
  path = "/" if path.empty?
  query_pairs = URI.decode_www_form(uri.query.to_s).reject do |key, _value|
    normalized_key = key.to_s.downcase
    normalized_key.start_with?("utm_") || TRACKING_QUERY_KEYS.include?(normalized_key)
  end
  query_pairs.sort_by! { |key, value| [key, value] }
  query = query_pairs.empty? ? "" : "?#{URI.encode_www_form(query_pairs)}"
  "#{host}#{path}#{query}"
rescue URI::InvalidURIError, ArgumentError
  nil
end

def related_identity?(left, right)
  return false if left.nil? || right.nil?
  return left == right if left.include?("/") || right.include?("/")

  left == right || left.end_with?(".#{right}") || right.end_with?(".#{left}")
end

def counted_status?(status, backlink_sample: false)
  statuses = backlink_sample ? BACKLINK_SAMPLE_COUNTED_STATUSES : COUNTED_STATUSES
  statuses.include?(status.to_s.strip.downcase)
end

def retryable_unresolved_status?(status)
  normalized = status.to_s.strip.downcase
  return false if normalized.empty?
  return false if NON_RETRYABLE_STATUS_PATTERNS.any? { |pattern| pattern.match?(normalized) }

  RETRYABLE_UNRESOLVED_STATUS_PATTERNS.any? { |pattern| pattern.match?(normalized) }
end

def normalized_row_type(value)
  normalized = value.to_s.strip.downcase.gsub(/[^a-z0-9]+/, "_").gsub(/\A_+|_+\z/, "")
  normalized.empty? ? "unknown" : normalized
end

def load_active_queue(active_csv_path)
  rows = CSV.read(
    active_csv_path,
    headers: true,
    encoding: "bom|utf-8",
    skip_lines: /\A\s*表格 1\s*\z/
  )
  headers = rows.headers.compact
  csv_basename = File.basename(active_csv_path)

  if headers.include?("平台名称") && headers.include?("提交入口/网址")
    queue_mode = "standard-platform"
    name_field = "平台名称"
    url_field = "提交入口/网址"
  elsif headers.include?("platform") && headers.include?("platform_url")
    # Success catalogs carry another website's historical outcomes. Only route
    # by name and URL; progress and evidence remain specific to this run's site.
    queue_mode = "standard-platform"
    name_field = "platform"
    url_field = "platform_url"
  elsif headers.include?("网站名称") && headers.include?("网址")
    queue_mode = "standard-platform"
    name_field = "网站名称"
    url_field = "网址"
  elsif headers.include?("名称/网址") && headers.include?("类型")
    queue_mode = "catalog-platform"
    url_field = "名称/网址"
    traffic_field = "流量"
    minimum_price_field = "最低价"
    access_model_field = "付费/免费"
    platform_type_field = "类型"
  elsif headers.include?("Free/Paid") && headers.include?("Link") && headers.include?("Category")
    queue_mode = "catalog-platform"
    url_field = "Link"
    traffic_field = "Traffic"
    access_model_field = "Free/Paid"
    platform_type_field = "Category"
  elsif headers.include?("Type") && headers.include?("URL")
    queue_mode = "backlink-sample"
  else
    abort "unsupported active CSV headers: #{rows.headers.compact.join(', ')}"
  end

  candidates = rows.each_with_object([]) do |row, result|
    if queue_mode == "backlink-sample"
      row_type = normalized_row_type(row["Type"])
      url = row["URL"].to_s.strip
      # Type is a discovery hint; unknown pages still need a visible-page disposition.
      next if url.empty?

      identity = target_page_identity(url)
      platform = normalized_host(url) || url
      result << {
        platform: platform,
        name: normalized_name(platform),
        url: url,
        identity: identity,
        target_identity: identity,
        source_key: "#{csv_basename}::#{row_type}::#{identity || url}",
        row_type: row_type,
        discovered_from: row["Discovered From"].to_s.strip,
        has_captcha: row["Has Captcha"].to_s.strip,
        link_strategy: row["Link Strategy"].to_s.strip,
        link_format: row["Link Format"].to_s.strip,
        has_url_field: row["Has URL Field"].to_s.strip
      }
    elsif queue_mode == "catalog-platform"
      url = row[url_field].to_s.strip
      next if url.empty?

      platform = normalized_host(url) || url
      identity = platform_identity(url)
      result << {
        platform: platform,
        name: normalized_name(platform),
        url: url,
        identity: identity,
        target_identity: target_page_identity(url),
        source_key: "#{csv_basename}::#{platform}::#{identity || url}",
        traffic: row[traffic_field].to_s.strip,
        minimum_price: minimum_price_field ? row[minimum_price_field].to_s.strip : "",
        access_model: row[access_model_field].to_s.strip,
        platform_type: row[platform_type_field].to_s.strip
      }
    else
      platform = row[name_field].to_s.strip
      url = row[url_field].to_s.strip
      next if platform.empty? || url.empty?

      identity = platform_identity(url)
      result << {
        platform: platform,
        name: normalized_name(platform),
        url: url,
        identity: identity,
        target_identity: target_page_identity(url),
        source_key: "#{csv_basename}::#{platform}::#{identity || url}"
      }
    end
  end

  [queue_mode, candidates]
end

def progress_csv_queue_mode(workspace, row, cache, csv_paths_by_basename)
  basename = File.basename(row["csv"].to_s)
  return nil if basename.empty?
  return cache[basename] if cache.key?(basename)

  canonical_path = File.join(workspace, "platforms", basename)
  path = ([canonical_path] + csv_paths_by_basename.fetch(basename, [])).find { |candidate| File.file?(candidate) }
  if path
    cache[basename] = load_active_queue(path).first
  else
    source_type = row["source_key"].to_s.split("::", 3)[1].to_s
    cache[basename] =
      if basename.downcase.include?("gefei") || %w[blog_comment profile forum_reply community_post].include?(source_type)
        "backlink-sample"
      end
  end
rescue CSV::MalformedCSVError
  cache[basename] = nil
end

def daily_counted_entries(daily_dir, website)
  entries = []
  Dir.glob(File.join(daily_dir, "*.md")).sort.each do |path|
    date = File.basename(path, ".md")
    File.foreach(path) do |line|
      next unless line.start_with?("|")
      next unless line.include?("| #{website} |")

      cells = line.split("|", -1)[1...-1].map(&:strip)
      next unless cells.include?("是")

      platform = cells[2].to_s
      urls = line.scan(%r{https?://[^\s|`]+}).map { |url| url.sub(/[),.;，。；]+\z/, "") }
      platform_url = cells[3].to_s
      evidence_url = cells[4].to_s
      identity = platform_identity(platform_url)
      identity ||= platform_identity(evidence_url)
      identity ||= urls.map { |url| platform_identity(url) }.compact.first
      target_identity = target_page_identity(platform_url)
      target_identity ||= target_page_identity(evidence_url)
      target_identity ||= urls.map { |url| target_page_identity(url) }.compact.first

      entries << {
        date: date,
        platform: platform,
        name: normalized_name(platform),
        identity: identity,
        target_identity: target_identity,
        line: line.strip,
        file: path
      }
    end
  end
  entries
end

csv_basename = File.basename(active_csv_path)
queue_mode, active_candidates = load_active_queue(active_csv_path)
backlink_sample_mode = queue_mode == "backlink-sample"
catalog_platform_mode = queue_mode == "catalog-platform"
abort "--retry-unresolved requires a catalog-platform CSV" if options[:retry_unresolved] && !catalog_platform_mode

progress_schema, progress_rows = load_progress_rows(progress_path, options[:website])
csv_paths_by_basename = Dir.glob(File.join(workspace, "**", "*.csv")).group_by { |path| File.basename(path) }
progress_queue_modes = {}
progress_rows.each do |row|
  progress_csv_queue_mode(workspace, row, progress_queue_modes, csv_paths_by_basename)
end
retry_progress_row = nil

if options[:retry_source_key]
  retry_rows = progress_rows.select { |row| row["source_key"] == options[:retry_source_key] }
  abort "retry source key not found: #{options[:retry_source_key]}" if retry_rows.empty?
  abort "retry source key is duplicated: #{options[:retry_source_key]}" if retry_rows.length > 1
  abort "retry row must be reopened as unprocessed before gate: #{options[:retry_source_key]}" unless retry_rows.first["state"] == "unprocessed"
  retry_progress_row = retry_rows.first
end

errors = []
duplicate_keys = progress_rows.group_by { |row| row["source_key"] }
                              .select { |key, rows| !key.to_s.empty? && rows.length > 1 }
duplicate_keys.each do |key, rows|
  errors << "duplicate source_key (#{rows.length} rows): #{key}"
end

daily_history = daily_counted_entries(daily_dir, options[:website])

progress_rows.each do |row|
  row_uses_sample_rules = progress_queue_modes[File.basename(row["csv"].to_s)] == "backlink-sample"
  next unless row["last_attempted"].to_s.start_with?(options[:today])
  next unless counted_status?(row["last_status"], backlink_sample: row_uses_sample_rules)

  current_name = normalized_name(row["platform"])
  if row_uses_sample_rules
    current_target_identity = target_page_identity(row["platform_url"])
    earlier_daily = daily_history.find do |entry|
      current_target_identity &&
        entry[:date] < options[:today] && entry[:target_identity] == current_target_identity
    end
    earlier_progress = progress_rows.find do |other|
      next false if other.equal?(row)
      next false unless other["last_attempted"].to_s[0, 10] < options[:today]

      other_uses_sample_rules = progress_queue_modes[File.basename(other["csv"].to_s)] == "backlink-sample"
      current_target_identity &&
        counted_status?(other["last_status"], backlink_sample: other_uses_sample_rules) &&
        target_page_identity(other["platform_url"]) == current_target_identity
    end
  else
    current_identity = platform_identity(row["platform_url"])
    earlier_daily = daily_history.find do |entry|
      entry[:date] < options[:today] &&
        (related_identity?(entry[:identity], current_identity) ||
         (!current_name.empty? && entry[:name] == current_name))
    end
    earlier_progress = progress_rows.find do |other|
      next false if other.equal?(row)
      next false unless other["last_attempted"].to_s[0, 10] < options[:today]

      other_uses_sample_rules = progress_queue_modes[File.basename(other["csv"].to_s)] == "backlink-sample"
      counted_status?(other["last_status"], backlink_sample: other_uses_sample_rules) &&
        related_identity?(platform_identity(other["platform_url"]), current_identity)
    end
  end

  duplicate = earlier_daily || earlier_progress
  next unless duplicate

  origin =
    if duplicate.is_a?(Hash)
      "#{duplicate[:date]} #{duplicate[:platform]} in #{File.basename(duplicate[:file])}"
    else
      "#{duplicate["last_attempted"]} #{duplicate["platform"]} in platform-progress.csv"
    end
  errors << "today counted duplicate: #{row["platform"]} (#{row["source_key"]}); earlier #{origin}"
end

cursor_progress_rows = progress_rows.reject { |row| row["source_key"] == options[:retry_source_key] }
processed_keys = cursor_progress_rows.map { |row| row["source_key"] }.compact.to_h { |key| [key, true] }
identity_cursor_progress_rows =
  if backlink_sample_mode
    cursor_progress_rows
  else
    cursor_progress_rows.select do |row|
      source_mode = progress_queue_modes[File.basename(row["csv"].to_s)]
      source_mode != "backlink-sample" || counted_status?(row["last_status"], backlink_sample: true)
    end
  end
processed_identities = identity_cursor_progress_rows.map { |row| platform_identity(row["platform_url"]) }.compact
processed_names = identity_cursor_progress_rows.map { |row| normalized_name(row["platform"]) }.reject(&:empty?)
daily_identities = daily_history.map { |entry| entry[:identity] }.compact
daily_target_identities = daily_history.map { |entry| entry[:target_identity] }.compact
daily_names = daily_history.map { |entry| entry[:name] }.reject(&:empty?)
retry_deferred_rows =
  if options[:retry_deferred]
    counted_progress_rows = progress_rows.select do |row|
      row_uses_sample_rules = progress_queue_modes[File.basename(row["csv"].to_s)] == "backlink-sample"
      counted_status?(row["last_status"], backlink_sample: row_uses_sample_rules)
    end
    progress_rows.select do |row|
      next false unless File.basename(row["csv"].to_s) == csv_basename
      next false unless row["state"] == "deferred"
      next false if row["last_attempted"].to_s.start_with?(options[:today])

      if backlink_sample_mode
        row_target_identity = target_page_identity(row["platform_url"])
        already_counted =
          row_target_identity &&
          (daily_target_identities.include?(row_target_identity) ||
          counted_progress_rows.any? do |counted_row|
            target_page_identity(counted_row["platform_url"]) == row_target_identity
          end)
      else
        row_identity = platform_identity(row["platform_url"])
        row_name = normalized_name(row["platform"])
        already_counted =
          daily_history.any? do |entry|
            related_identity?(entry[:identity], row_identity) ||
              (!row_name.empty? && entry[:name] == row_name)
          end ||
          counted_progress_rows.any? do |counted_row|
            related_identity?(platform_identity(counted_row["platform_url"]), row_identity) ||
              (!row_name.empty? && normalized_name(counted_row["platform"]) == row_name)
          end
      end
      !already_counted
    end
  else
    []
  end

next_candidate = nil
active_total_rows = active_candidates.length
active_handled_rows = 0
active_remaining_rows = 0
active_candidates.each do |candidate|
  if options[:retry_unresolved]
    current_key_already_persisted = processed_keys.key?(candidate[:source_key])
    matching_progress = progress_rows.select do |row|
      next false if File.basename(row["csv"].to_s) == csv_basename

      source_mode = progress_queue_modes[File.basename(row["csv"].to_s)]
      if source_mode == "backlink-sample"
        next false unless counted_status?(row["last_status"], backlink_sample: true)
      end

      row_identity = platform_identity(row["platform_url"])
      row_name = normalized_name(row["platform"])
      related_identity?(row_identity, candidate[:identity]) ||
        (!candidate[:name].empty? && row_name == candidate[:name])
    end
    already_counted = matching_progress.any? do |row|
      row_uses_sample_rules = progress_queue_modes[File.basename(row["csv"].to_s)] == "backlink-sample"
      counted_status?(row["last_status"], backlink_sample: row_uses_sample_rules)
    end ||
      daily_history.any? do |entry|
        related_identity?(entry[:identity], candidate[:identity]) ||
          (!candidate[:name].empty? && entry[:name] == candidate[:name])
      end
    latest = matching_progress.max_by { |row| row["last_attempted"].to_s }
    retryable = latest &&
      !latest["last_attempted"].to_s.start_with?(options[:today]) &&
      retryable_unresolved_status?(latest["last_status"])
    if current_key_already_persisted || already_counted || !retryable
      active_handled_rows += 1
    else
      active_remaining_rows += 1
      next_candidate ||= candidate.merge(
        retry_origin_source_key: latest["source_key"],
        retry_origin_status: latest["last_status"]
      )
    end
    next
  end

  if options[:retry_deferred]
    retry_row = retry_deferred_rows.find do |row|
      if backlink_sample_mode
        row["source_key"] == candidate[:source_key] ||
          target_page_identity(row["platform_url"]) == candidate[:target_identity]
      else
        normalized_name(row["platform"]) == candidate[:name] &&
          related_identity?(platform_identity(row["platform_url"]), candidate[:identity])
      end
    end
    if retry_row
      active_remaining_rows += 1
      next_candidate ||= candidate.merge(source_key: retry_row["source_key"])
    else
      active_handled_rows += 1
    end
    next
  end

  explicit_retry_match =
    if retry_progress_row
      if backlink_sample_mode
        retry_progress_row["source_key"] == candidate[:source_key] ||
          target_page_identity(retry_progress_row["platform_url"]) == candidate[:target_identity]
      else
        normalized_name(retry_progress_row["platform"]) == candidate[:name] &&
          related_identity?(platform_identity(retry_progress_row["platform_url"]), candidate[:identity])
      end
    else
      false
    end
  candidate = candidate.merge(source_key: options[:retry_source_key]) if explicit_retry_match

  already_processed =
    !explicit_retry_match &&
    if backlink_sample_mode
      processed_keys.key?(candidate[:source_key])
    else
      processed_keys.key?(candidate[:source_key]) ||
        processed_identities.any? { |known| related_identity?(known, candidate[:identity]) } ||
        daily_identities.any? { |known| related_identity?(known, candidate[:identity]) } ||
        processed_names.include?(candidate[:name]) ||
        daily_names.include?(candidate[:name])
    end
  if already_processed
    active_handled_rows += 1
    next
  end

  active_remaining_rows += 1
  next_candidate ||= candidate
end

if next_candidate.nil?
  errors << "no unprocessed candidate remains in #{csv_basename}"
elsif options[:expect_next_source_key] && next_candidate[:source_key] != options[:expect_next_source_key]
  errors << "cursor mismatch: expected #{options[:expect_next_source_key]}, got #{next_candidate[:source_key]}"
end

puts "RESUME_GATE=#{errors.empty? ? "PASS" : "FAIL"}"
puts "website=#{options[:website]}"
puts "active_csv=#{csv_basename}"
puts "queue_mode=#{queue_mode}"
puts "progress_schema=#{progress_schema}"
puts "progress_rows=#{progress_rows.length}"
puts "historical_counted_rows=#{daily_history.length}"
puts "active_total_rows=#{active_total_rows}"
puts "active_handled_rows=#{active_handled_rows}"
puts "active_remaining_rows=#{active_remaining_rows}"
puts "retry_source_key=#{options[:retry_source_key]}" if options[:retry_source_key]
puts "retry_mode=deferred" if options[:retry_deferred]
puts "retry_mode=unresolved" if options[:retry_unresolved]
if next_candidate
  puts "next_platform=#{next_candidate[:platform]}"
  puts "next_url=#{next_candidate[:url]}"
  puts "next_source_key=#{next_candidate[:source_key]}"
  if backlink_sample_mode
    puts "next_row_type=#{next_candidate[:row_type]}"
    puts "next_target_identity=#{next_candidate[:target_identity]}"
    puts "next_discovered_from=#{next_candidate[:discovered_from]}"
    puts "next_has_captcha=#{next_candidate[:has_captcha]}"
    puts "next_link_strategy=#{next_candidate[:link_strategy]}"
    puts "next_link_format=#{next_candidate[:link_format]}"
    puts "next_has_url_field=#{next_candidate[:has_url_field]}"
  elsif catalog_platform_mode
    puts "next_traffic=#{next_candidate[:traffic]}"
    puts "next_minimum_price=#{next_candidate[:minimum_price]}"
    puts "next_access_model=#{next_candidate[:access_model]}"
    puts "next_platform_type=#{next_candidate[:platform_type]}"
    if options[:retry_unresolved]
      puts "next_retry_origin_source_key=#{next_candidate[:retry_origin_source_key]}"
      puts "next_retry_origin_status=#{next_candidate[:retry_origin_status]}"
    end
  end
end
errors.each { |error| warn "ERROR: #{error}" }

exit(errors.empty? ? 0 : 2)

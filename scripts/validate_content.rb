#!/usr/bin/env ruby
# frozen_string_literal: true

require "pathname"
require "date"
require "set"
require "uri"
require "yaml"

ROOT = Pathname.new(__dir__).parent
CONTENT_GLOBS = %w[_essays/*.md _poems/*.md _sayings/*.md _quotes/*.md _thoughts/*.md themes/*.md *.md].freeze
COLLECTION_GLOBS = %w[_essays/*.md _poems/*.md _sayings/*.md _quotes/*.md _thoughts/*.md].freeze

errors = []
warnings = []
titles = Hash.new { |hash, key| hash[key] = [] }
urls = Set.new

def content_paths(globs)
  globs.flat_map { |glob| Dir.glob(ROOT.join(glob)).map { |file| Pathname.new(file) } }
end

def front_matter(path)
  text = path.read
  return [{}, text] unless text.start_with?("---\n")

  _opening, yaml, body = text.split(/^---\s*$/, 3)
  [YAML.safe_load(yaml, permitted_classes: [Date, Time], aliases: false) || {}, body || ""]
rescue Psych::Exception => e
  [{}, text, "Invalid YAML front matter: #{e.message}"]
end

def local_reference?(url)
  return false if url.nil? || url.empty?
  return false if url.start_with?("#", "mailto:", "tel:", "{{")
  return false if url.match?(%r{\A[a-z][a-z0-9+\-.]*://}i)

  true
end

def valid_absolute_url?(url)
  uri = URI.parse(url)
  uri.is_a?(URI::HTTP) && uri.host
rescue URI::InvalidURIError
  false
end

def strip_fragment_and_query(path)
  path.to_s.sub(/[?#].*\z/, "")
end

def local_path_exists?(url, known_urls)
  target = strip_fragment_and_query(url)
  return true if target.empty?

  if target.start_with?("/")
    return true if known_urls.include?(target)
    return true if known_urls.include?("#{target}/")

    asset_path = ROOT.join(target.sub(%r{\A/}, ""))
    return true if asset_path.file?
  else
    return true if ROOT.join(target).file?
  end

  false
end

def collection_url(path, data = {})
  permalink = data["permalink"].to_s.strip
  return permalink if !permalink.empty?

  rel = path.relative_path_from(ROOT).to_s
  stem = path.basename(".md").to_s

  case rel
  when %r{\A_essays/}
    "/essays/#{stem.sub(/\A\d{4}-\d{2}-\d{2}-/, "")}/"
  when %r{\A_poems/}
    "/poetry/#{stem}/"
  when %r{\A_sayings/}
    "/sayings/#{stem}/"
  when %r{\A_quotes/}
    "/voices/#{stem}/"
  when %r{\A_thoughts/}
    "/thoughts/#{stem}/"
  end
end

content_paths(COLLECTION_GLOBS).each do |path|
  data, = front_matter(path)
  rel = path.relative_path_from(ROOT).to_s
  title = data["title"].to_s.strip
  titles[title.downcase] << rel unless title.empty?

  url = collection_url(path, data)
  urls << url if url
end

Dir.glob(ROOT.join("*.md")).each do |file|
  path = Pathname.new(file)
  slug = path.basename(".md").to_s
  urls << "/#{slug}/"
end

content_paths(CONTENT_GLOBS).each do |path|
  data, body, yaml_error = front_matter(path)
  rel = path.relative_path_from(ROOT).to_s
  errors << "#{rel}: #{yaml_error}" if yaml_error

  image = data["image"]
  if image
    asset_path = ROOT.join(image.to_s.sub(%r{\A/}, ""))
    errors << "#{rel}: image does not exist: #{image}" unless asset_path.file?
    errors << "#{rel}: image_alt is required when image is set" if data["image_alt"].to_s.strip.empty?
  end

  image_credit_url = data["image_credit_url"].to_s.strip
  if !image_credit_url.empty? && !valid_absolute_url?(image_credit_url)
    errors << "#{rel}: image_credit_url must be an absolute http(s) URL: #{image_credit_url}"
  elsif !data["image_credit"].to_s.strip.empty? && image_credit_url.empty? && !data["image_credit"].to_s.match?(/Greg Conrad Smith|author|OpenAI/i)
    warnings << "#{rel}: image_credit has no image_credit_url"
  end

  body.scan(/<img\b[^>]*>/i).each do |tag|
    src = tag[/\bsrc=["']([^"']+)["']/i, 1]
    alt = tag[/\balt=["']([^"']*)["']/i, 1]
    errors << "#{rel}: inline image is missing alt text: #{src || tag}" if alt.nil?
    errors << "#{rel}: inline image does not exist: #{src}" if local_reference?(src) && !local_path_exists?(src, urls)
  end

  body.scan(/\[[^\]]+\]\(([^)\s]+)(?:\s+["'][^"']*["'])?\)/).flatten.each do |href|
    errors << "#{rel}: local Markdown link does not exist: #{href}" if local_reference?(href) && !local_path_exists?(href, urls)
  end

  body.scan(/<a\b[^>]*\bhref=["']([^"']+)["']/i).flatten.each do |href|
    errors << "#{rel}: local HTML link does not exist: #{href}" if local_reference?(href) && !local_path_exists?(href, urls)
  end
end

titles.each_value do |paths|
  next if paths.length < 2

  warnings << "duplicate title: #{paths.join(', ')}"
end

featured_path = ROOT.join("_data/featured_writing.yml")
if featured_path.file?
  featured = YAML.safe_load(featured_path.read, permitted_classes: [Date, Time], aliases: false) || {}
  Array(featured["items"]).each do |item|
    url = item["url"].to_s
    image = item["image"].to_s

    errors << "_data/featured_writing.yml: featured item URL is stale: #{url}" unless urls.include?(url)
    errors << "_data/featured_writing.yml: featured image does not exist: #{image}" if !image.empty? && !ROOT.join(image.sub(%r{\A/}, "")).file?
    errors << "_data/featured_writing.yml: featured image_alt is required for #{url}" if !image.empty? && item["image_alt"].to_s.strip.empty?
  end
end

warn warnings.join("\n") if warnings.any?

if errors.any?
  warn errors.join("\n")
  exit 1
end

puts warnings.any? ? "Content references look good with warnings." : "Content references look good."

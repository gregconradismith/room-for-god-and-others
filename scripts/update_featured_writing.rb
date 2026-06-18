#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "fileutils"
require "pathname"
require "time"
require "yaml"

ROOT = Pathname.new(__dir__).parent
DATA_PATH = ROOT.join("_data/featured_writing.yml")
ITEM_LIMIT = 6

COLLECTIONS = {
  "_essays" => { "label" => "Essay", "base" => "/essays", "use_title_permalink" => true },
  "_poems" => { "label" => "Poem", "base" => "/poetry" },
  "_aphorisms" => { "label" => "Aphorism", "base" => "/aphorisms" },
  "_blurbs" => { "label" => "Blurb", "base" => "/blurbs" },
  "_quotes" => { "label" => "Quotation", "base" => "/quotes" }
}.freeze

def front_matter(path)
  text = path.read
  return {} unless text.start_with?("---\n")

  _opening, yaml, = text.split(/^---\s*$/, 3)
  YAML.safe_load(yaml, permitted_classes: [Date, Time], aliases: false) || {}
rescue Psych::Exception => e
  warn "#{path}: #{e.message}"
  {}
end

def slug_for(path, data, config)
  return data["permalink"] if data["permalink"].to_s.strip != ""

  slug = path.basename(".md").to_s
  slug = slug.sub(/\A\d{4}-\d{2}-\d{2}-/, "") if config["use_title_permalink"]
  "#{config["base"]}/#{slug}/"
end

def clean_excerpt(value)
  value.to_s.lines.map { |line| line.sub(/\A\s*>\s?/, "") }.join.strip
end

items = []

COLLECTIONS.each do |dir, config|
  ROOT.join(dir).glob("*.md").each do |path|
    data = front_matter(path)
    title = data["title"].to_s.strip
    next if title.empty?

    items << {
      "type" => data["draft"] ? "Draft Essay" : config["label"],
      "title" => title,
      "url" => slug_for(path, data, config),
      "excerpt" => clean_excerpt(data["excerpt"]),
      "date" => data["date"].to_s,
      "image" => data["image"].to_s,
      "image_alt" => data["image_alt"].to_s,
      "image_position" => data["image_position"].to_s
    }
  end
end

raise "No writing items found" if items.empty?

sample = items.sample([ITEM_LIMIT, items.length].min)

FileUtils.mkdir_p(DATA_PATH.dirname)
DATA_PATH.write(
  {
    "updated" => Date.today.iso8601,
    "items" => sample
  }.to_yaml
)

puts "Updated #{DATA_PATH} with #{sample.length} random writing items."

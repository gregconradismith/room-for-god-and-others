#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "cgi"
require "fileutils"
require "net/http"
require "rexml/document"
require "time"
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
DATA_PATH = File.join(ROOT, "_data", "goodreads.yml")
BOOK_LIMIT = 5

def rss_text(url)
  uri = URI(url)
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", open_timeout: 10, read_timeout: 20) do |http|
    response = http.get(uri.request_uri)
    response.value
    response.body
  end
end

def element_text(parent, name)
  parent.elements[name]&.text.to_s.strip
end

def clean_book_url(url)
  url.sub(/\?.*\z/, "")
end

def book_url_for(item)
  book_id = element_text(item, "book_id")
  return "https://www.goodreads.com/book/show/#{book_id}" unless book_id.empty?

  description = element_text(item, "description")
  href = description[/href="([^"]+)"/, 1]
  clean_book_url(CGI.unescapeHTML(href || element_text(item, "link")))
end

def currently_reading?(item)
  shelves = element_text(item, "user_shelves")
  shelves.split(",").map(&:strip).include?("currently-reading")
end

def read_at_for(item)
  element_text(item, "user_read_at")
end

def recently_read?(item)
  !currently_reading?(item) && !read_at_for(item).empty?
end

def status_for(item)
  "Read #{format_date(read_at_for(item))}"
end

def format_date(value)
  return "" if value.to_s.strip.empty?

  Time.parse(value).strftime("%b %-d, %Y")
rescue ArgumentError
  value.to_s
end

def rating_for(item)
  rating = element_text(item, "user_rating").to_i
  return "" if rating <= 0

  "#{rating} #{rating == 1 ? "star" : "stars"}"
end

existing = if File.file?(DATA_PATH)
             YAML.safe_load(File.read(DATA_PATH), aliases: false) || {}
           else
             {}
           end
profile_url = existing.fetch("profile_url", "https://www.goodreads.com/user/show/29023561-greg-conradi-smith")
feed_url = existing.fetch("feed_url", "https://www.goodreads.com/review/list_rss/29023561")

begin
  doc = REXML::Document.new(rss_text(feed_url))
  books = []

  REXML::XPath.each(doc, "//item") do |item|
    next unless recently_read?(item)

    books << {
      "title" => element_text(item, "title"),
      "author" => element_text(item, "author_name"),
      "url" => book_url_for(item),
      "image" => element_text(item, "book_medium_image_url"),
      "status" => status_for(item),
      "rating" => rating_for(item)
    }
    break if books.length == BOOK_LIMIT
  end

  raise "Goodreads feed returned no books" if books.empty?

  FileUtils.mkdir_p(File.dirname(DATA_PATH))
  File.write(
    DATA_PATH,
    {
      "profile_url" => profile_url,
      "feed_url" => feed_url,
      "updated" => Date.today.iso8601,
      "books" => books
    }.to_yaml
  )

  puts "Updated #{DATA_PATH} from Goodreads RSS."
rescue StandardError => e
  warn "Goodreads refresh skipped: #{e.message}"
  warn "Using committed #{DATA_PATH} snapshot."
  exit ENV["STRICT_GOODREADS"] == "1" ? 1 : 0
end

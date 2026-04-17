require 'dotenv/load'
require 'json'

APP_NAME = ENV.fetch('APP_NAME', 'docker-ruby')
APP_ENV  = ENV.fetch('APP_ENV', 'development')

GEMS = %w[
  faraday httparty rest-client
  sinatra rack puma
  activerecord pg redis mongo
  dotenv activesupport nokogiri ox
  bcrypt jwt dry-validation
].freeze

def list_gems
  GEMS.map { |name| { name: name } }.sort_by { |g| g[:name] }
end

def main
  puts "=== #{APP_NAME} | env=#{APP_ENV} | ruby=#{RUBY_VERSION} ===\n\n"
  puts 'Installed gems:'
  puts '-' * 40
  list_gems.each { |g| puts "  #{g[:name]}" }
  puts '-' * 40
  puts "Total: #{GEMS.size} gems"
end

main if __FILE__ == $PROGRAM_NAME

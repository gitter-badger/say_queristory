require 'pry'
require 'tweetstream'
require 'dotenv'
require 'uri'

TweetStream.configure do |config|
  Dotenv.load
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

TweetStream::Client.new.follow(2503690447) do |status|
  `say "#{status.text.gsub(URI.regexp(['http', 'https']), '')}"`
end

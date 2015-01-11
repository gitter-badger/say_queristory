require 'pry'
require 'tweetstream'
require 'dotenv'
require 'uri'

def has_multi_byte?(str)
  str.bytes do |b|
    return true if  (b & 0b10000000) != 0
  end
  false
end

TweetStream.configure do |config|
  Dotenv.load
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

TweetStream::Client.new.follow(2503690447) do |status|
  text_to_speech = status.text.gsub(URI.regexp(['http', 'https']), '')

  if has_multi_byte?(text_to_speech)
    text_to_speech = text_to_speech.gsub(' ', '、')
  else
    options = '-vAlex'
  end

  `say "#{options}" "#{text_to_speech}"`
end

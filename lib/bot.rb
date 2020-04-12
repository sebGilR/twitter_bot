require 'twitter'
require_relative 'config'

class TwitterBot
  attr_reader :tweets
  include Config
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = CONSUMER_KEY
      config.consumer_secret     = CONSUMER_SECRET
      config.access_token        = ACCESS_TOKEN
      config.access_token_secret = ACCESS_TOKEN_SECRET
    end
    @tweets = []
  end

  def get_tweets(keyword)
    @tweets = @client.search("#{keyword}", result_type: 'popular').take(5)
  end
end

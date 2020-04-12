require 'twitter'
require_relative 'config'

class TwitterBot
  include Config
  attr_reader :tweets
  attr_reader :curated

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = CONSUMER_KEY
      config.consumer_secret     = CONSUMER_SECRET
      config.access_token        = ACCESS_TOKEN
      config.access_token_secret = ACCESS_TOKEN_SECRET
    end
    @tweets = []
    @curated = @tweets.sample
  end

  

  def get_tweets(keyword)
    @tweets = @client.search("#{keyword} -government -rt", lang: 'en', result_type: 'popular', count: 100).take(5)
    fix_results(keyword)
  end

  def fix_results(keyword)
    @tweets = @client.search("#{keyword} -government -rt", lang: 'en', result_type: 'recent').take(5) if @tweets == []
  end

  def like
    @tweets.each do |tweet|
      @client.favorite(@tweets)
      sleep 60
    end
  end

  def retweet
    @tweets.each do |tweet|
      @client.retweet(tweet) if tweet.user.followers_count >= 20
      sleep 60
    end
  end

  def follow
    2.times do
      p @tweets
      @client.follow(@tweets.sample.user.id)
      sleep 140
    end
  end

  def reset
    @tweets = []
  end
end

bot = TwitterBot.new
bot.get_tweets('react and redux')
bot.tweets.each { |tweet| puts tweet.text + "\n\n --------------------" }
# bot.retweet
# bot.follow
# bot.reset
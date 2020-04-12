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
    puts 'Retrieving tweets...'
    sleep 1
    @tweets = @client.search("#{keyword} -rt", lang: 'en', result_type: 'popular', count: 100).take(5)
    fix_results(keyword)
  end

  def fix_results(keyword)
    if @tweets == []
      @tweets = @client.search("#{keyword} -government -rt", lang: 'en', result_type: 'recent').take(15)
    end
  end

  def like
    puts 'Liking...'
    @tweets.each do |tweet|
      @client.favorite(tweet) if !(tweet.text =~ /free|free course|click/i)
      sleep 1
    end
  end

  def retweet
    puts 'Retweeting found posts...'
    @tweets.each do |tweet|
      @client.retweet(tweet) if tweet.user.followers_count >= 20 && !(tweet.text =~ /free|free course|click/i)
      sleep 1
    end
  end

  def follow
    puts 'Following 2 users from the saved results'
    2.times do
      @client.follow(@tweets.sample.user.id)
      sleep 1
    end
  end

  def reset
    puts 'Process finished, will restart in 6 hours.'
    puts 'Press CTRL + C to abort now.'
    @tweets = []
  end
end



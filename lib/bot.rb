require 'twitter'
require_relative 'config'

class TwitterBot
  include Config

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.access_token = ACCESS_TOKEN
      config.access_token_secret = ACCESS_TOKEN_SECRET
    end
    @tweets = []
  end

  private

  def get_tweets(keyword)
    puts 'Retrieving tweets...'
    sleep 1
    @tweets = @client.search("#{keyword} -rt", lang: 'en', result_type: 'popular', count: 100).take(5)
    alt_results(keyword)
  end

  def alt_results(keyword)
    @tweets = @client.search("#{keyword} -government -rt", lang: 'en', result_type: 'recent').take(15) if @tweets == []
  end

  def like
    puts 'Liking...'
    @tweets.each do |tweet|
      @client.favorite(tweet) unless tweet.text =~ /free|free course|click/i
      sleep 1
    end
  end

  def retweet
    puts 'Retweeting found posts...'
    @tweets.each do |tweet|
      @client.retweet(tweet) unless tweet.user.followers_count <= 20 && (tweet.text =~ /free|free course|click/i)
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
    puts "\nProcess finished, it will restart in 6 hours."
    puts "\n\tPress CTRL + C to abort now."
    @tweets = []
  end

  public

  def run(topic)
    loop do
      get_tweets(topic)
      @tweets.each { |tweet| puts tweet.full_text + "\n\t ------------" }
      like
      retweet
      follow
      reset
      sleep 21_600
    end
  end
end

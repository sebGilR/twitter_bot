require_relative '../lib/bot.rb'

puts 'W E L C O M E | Networking Bot'
puts 'Please enter the following parameters to run the bot...'
sleep 1
print 'What topics would you like the bot to interact with?: '
input_topic = gets.chomp

def run(topic)
  while true
    bot = TwitterBot.new
    bot.get_tweets(topic)
    bot.tweets.each { |tweet| puts tweet.full_text + "\n\t ------------" }
    bot.like
    bot.retweet
    bot.follow
    bot.reset
    sleep 21600
  end
end

run(input_topic)

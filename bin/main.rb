require_relative '../lib/bot.rb'

puts 'W E L C O M E | Networking Bot'
puts 'Please enter the following parameters to run the bot...'
sleep 1
print 'What topics would you like the bot to interact with?: '
input_topic = gets.chomp

bot = TwitterBot.new

bot.run(input_topic)

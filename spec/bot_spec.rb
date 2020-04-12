require 'twitter'
require_relative '../lib/bot.rb'

RSpec.describe TwitterBot do
  let(:bot) { described_class.new }
  let(:tweets) { bot.get_tweets('javascript') }

  describe '#get_tweets' do
    it 'gets and stores tweets' do
      bot_dbl = double('bot')
      expect(bot_dbl).to receive(:get_tweets).with('topic').and_return([])
      bot_dbl.get_tweets('topic')
    end
  end
end
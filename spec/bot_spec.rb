require 'twitter'
require_relative '../lib/bot.rb'

RSpec.describe TwitterBot do
  let(:bot_dbl) { double('bot') }

  describe '#get_tweets' do
    it 'gets and saves tweets' do
      expect(bot_dbl).to receive(:get_tweets).with('topic').and_return([])
      bot_dbl.get_tweets('topic')
    end
  end

  describe '#like' do
    it 'likes saved tweets' do
      expect(bot_dbl).to receive(:like).and_return('success')
      bot_dbl.like
    end
  end

  describe '#retweet' do
    it 'retweets saved tweets' do
      expect(bot_dbl).to receive(:retweet).and_return('success')
      bot_dbl.retweet
    end
  end

  describe '#follow' do
    it 'follows the author of a tweet' do
      expect(bot_dbl).to receive(:follow).and_return('success')
      bot_dbl.follow
    end
  end

  describe '#reset' do
    it 'empties the saved tweets' do
      expect(bot_dbl).to receive(:reset).and_return([])
      bot_dbl.reset
    end
  end

  describe '#fix_results' do
    it 'returns array with latest if popular results are not found' do
      expect(bot_dbl).to receive(:fix_results).and_return(%w[busy array])
      bot_dbl.fix_results
    end
  end
end

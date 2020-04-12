require 'twitter'
require 'config'

class TwitterBot
  include 'config'
  def initialize
    @client = client
    @tweets = []
  end
end
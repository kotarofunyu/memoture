# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
  require 'twitter'
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['API_KEY']
    config.consumer_secret = ENV['API_KEY_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end

  def self.get_tweet_full_text(tweet_id)
    tweet = @client.status(tweet_id, options={tweet_mode: "extended"})
    return tweet.text
  end
end

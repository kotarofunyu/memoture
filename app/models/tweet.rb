# == Schema Information
#
# Table name: tweets
#
#  id               :bigint           not null, primary key
#  tweet_created_at :datetime
#  url              :string(255)
#  user_name        :string(255)
#  user_screen_name :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  memo_id          :integer
#
class Tweet < ApplicationRecord
  belongs_to :memo

  require 'twitter'
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['API_KEY']
    config.consumer_secret = ENV['API_KEY_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end

  def self.get_tweet_id(text)
    if text.include?("?")
      tweet_id = text.split('?')[0].split('/').grep(/^[0-9]+$/)[0].to_i
    else
      tweet_id = text.split('/').grep(/^[0-9]+$/)[0].to_i
    end
    return tweet_id
  end

  def self.get_tweet_object(text)
    tweet_id = self.get_tweet_id(text)
    tweet = @client.status(tweet_id, options={tweet_mode: "extended"})
    return tweet
  end

  # def self.get_tweet_full_text(tweet_id)
  #   tweet = @client.status(tweet_id, options={tweet_mode: "extended"})
  #   p tweet.user
  #   p tweet.user.name
  #   p tweet.user.screen_name
  #   return tweet.text
  # end

  # def self.create_tweet(url, tweet_id)
  #   tweet = @client.status(tweet_id, options={})
  #   return Tweet.new(
  #     url: url,
  #     user_name: tweet.user.name,
  #     user_screen_name: tweet.user_screen_name,
  #     tweet_created_at: tweet.created_at
  #   )
  # end
end

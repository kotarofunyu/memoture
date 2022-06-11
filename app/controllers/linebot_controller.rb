class LinebotController < ApplicationController
  require 'line/bot'
  def client
    @client = Line::Bot::Client.new do |config|
      config.channel_token = ENV["LINE_CHANNEL_ACCESS_TOKEN"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    end
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    if client.validate_signature(body, signature)
      events = client.parse_events_from(body)
      event = events.select { _1.class == Line::Bot::Event::Message }.first
      if event.type == Line::Bot::Event::MessageType::Text
        text = event.message['text']
        first_line = text.split("\n")[0]
        message = { type: 'text', text: "メモしました\n---------------\n#{create(text)}" }
        client.reply_message(event['replyToken'], message)  
        head :ok
      else
        head :unprocessable_entity
      end
    else
      head :bad_request
    end
  end

  private

  def create(text)
    if text.include?("twitter.com")
      tweet = Tweet.get_tweet_object(text)
      memo = Memo.new(text: tweet.text)
      memo.tweet = Tweet.new(
        url: text,
        user_name: tweet.user.name,
        user_screen_name: tweet.user.screen_name
      )
      memo.save!
    else
      memo = Memo.create(text: text)
    end
    return memo.text
  end

  def twitter_save(text)
    if text.include?("?")
      tweet_id = text.split('?')[0].split('/').grep(/^[0-9]+$/)[0].to_i
    else
      tweet_id = text.split('/').grep(/^[0-9]+$/)[0].to_i
    end
    return tweet_content = Tweet.get_tweet_full_text(tweet_id)
  end
end

require 'line/bot'

class Memos::Registration
  include ActiveModel::Model
  include ActiveModel::Attributes

  define_model_callbacks :save

  attribute :body
  attribute :signature

  with_options presence: true do
    validates :body
    validates :signature
  end

  validate do
    errors.add(:base, :invalid) unless client.validate_signature(body, signature)
  end

  validate do
    errors.add(:base, :invalid) unless event.type == Line::Bot::Event::MessageType::Text
  end

  before_save { throw(:abort) if invalid? }

  after_save do
    message = { type: 'text', text: "メモしました\n---------------\n#{text}" }
    client.reply_message(event['replyToken'], message)  
  end

  def save
    run_callbacks :save do
      if text.include?("twitter.com")
        tweet = Tweet.get_tweet_object(text)
        memo = Memo.new(text: tweet.text)
        memo.build_tweet(
          url: text,
          user_name: tweet.user.name,
          user_screen_name: tweet.user.screen_name
        )
        memo.save!
        @text = tweet.text
      else
        Memo.create!(text: text)
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_token = ENV["LINE_CHANNEL_ACCESS_TOKEN"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    end
  end

  def event
    @event ||= client.parse_events_from(body).select { |e| e.class == Line::Bot::Event::Message }.first
  end

  def text
    @text = event.message['text']
  end
end

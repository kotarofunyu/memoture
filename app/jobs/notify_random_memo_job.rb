class NotifyRandomMemoJob < ApplicationJob
  queue_as :default

  def perform
    client.push_message(
      user_id,
      messages
    )
  end

  def user_id
    ENV["LINE_USER_ID"]
  end

  def messages
    text = Memo.from_twitter.where('id >= ?', rand(Memo.first.id..Memo.last.id)).first.text
    { type: 'text', text: text }
  end

  def client
    @clinet ||= Line::Bot::Client.new do |config|
      config.channel_token = ENV["LINE_CHANNEL_ACCESS_TOKEN"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    end
  end
end

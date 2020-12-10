class LinebotController < ApplicationController
  require 'line/bot'

  def callback
    binding.pry
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          text = event.message['text']
          if text.include?("\n")
            message = {
              type: 'text',
              text: "改行しましたね。"
            }
          end
          # int_regexp = /^[0-9]+$/
          # if event.message['text'].match?(int_regexp)
          #   id = event.message['text'].to_i
          #   memo = Memo.find_by(id: id)
          #   message = {
          #     type: 'text',
          #     text: "メモを見つけました！: #{memo.text}"
          #   }
          # else
          #   Memo.create!(
          #     text: event.message['text']
          #   )
          #   message = {
          #     type: 'text',
          #     text: "メモを作成しました！\n#{event.message['text']}"
          #   }
          # end
        end
      end
      client.reply_message(event['replyToken'], message)
    end
    head :ok
  end

  private

# LINE Developers登録完了後に作成される環境変数の認証
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def create
    @memo = Memo.create(text: text)
  end

  def index
    @memos = Memo.all
  end

  def search
    @memos = Memo.where('text like?', '%http%')
    # @memos = Memo.where('text like?', "%#{query}%"
  end
end

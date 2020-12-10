class LinebotController < ApplicationController
  require 'line/bot'

  def callback
    # binding.pry
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
            first_line = text.split("\n")[0]
            if first_line.include?("検索") || first_line.include?("一覧")
              if first_line.include?("検索")
                # search
                message = {
                  type: 'text',
                  text: search
                }
              else
                # index
                message = {
                  type: 'text',
                  text: index
                }
              end
            else
              # create(text)
              message = {
                type: 'text',
                text: create(text)
              }
            end
          else
            message = {
              type: 'text',
              text: create(text)
            }
          end
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

  def create(text)
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

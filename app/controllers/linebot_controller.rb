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
          first_line = text.split("\n")[0]
          if text.include?("\n") && first_line.include?("検索")
            # search
            message = {
              type: 'text',
              text: search(text.split("\n")[1])
            }
          elsif first_line.include?("一覧")
            # index
            message = {type: 'text', text: index}
          else
            # create(text)
            message = {type: 'text', text: create(text)}
          end
        end
      end
      puts message
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
    memo= Memo.create(text: text)
    return memo.text
  end

  def index
    result = Memo.pluck('text')
    return memos = result.join("\n")
  end

  def search(query)
    # @memos = Memo.where('text like?', '%http%')
    result = Memo.pluck('text').select { |text| text.include?(query) }
    memos = result.join("\n")
    return memos
    # @memos = Memo.where('text like?', "%#{query}%"
  end
end

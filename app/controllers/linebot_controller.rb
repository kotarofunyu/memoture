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
          if text.include?("\n") && first_line.include?('検索')
            # search
            message = {
              type: 'text',
              text: search(text.split("\n")[1])
            }
          elsif first_line.include?('一覧')
            # index
            message = { type: 'text', text: index }
          else
            # create
            message = { type: 'text', text: "メモしました\n---------------\n#{create(text)}" }
          end
        end
      end
      puts message
      client.reply_message(event['replyToken'], message)
    end
    head :ok
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

  def index
    result = Memo.pluck('text')
    return memos = result.join("\n")
  end

  def search(query)
    result = Memo.pluck('text').select { |text| text.include?(query) }
    section_line = '------------------------------'
    result.blank? ? memos = '該当するmemoがありませんでした。' : memos = result.join("\n#{section_line}\n")
    return memos
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

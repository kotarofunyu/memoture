class AddTweetIdToMemo < ActiveRecord::Migration[6.0]
  def change
    add_column :memos, :tweet_id, :int
  end
end

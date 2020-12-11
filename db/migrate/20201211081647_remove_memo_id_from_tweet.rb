class RemoveMemoIdFromTweet < ActiveRecord::Migration[6.0]
  def change
    remove_column :tweets, :memo_id, :int
  end
end

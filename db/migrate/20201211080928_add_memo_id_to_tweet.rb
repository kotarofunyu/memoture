class AddMemoIdToTweet < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :memo_id, :int
  end
end

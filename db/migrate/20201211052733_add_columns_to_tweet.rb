class AddColumnsToTweet < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :user_name, :string
    add_column :tweets, :user_screen_name, :string
    add_column :tweets, :url, :string
  end
end

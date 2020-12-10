class AddTextToMemo < ActiveRecord::Migration[6.0]
  def change
    add_column :memos, :text, :text
  end
end

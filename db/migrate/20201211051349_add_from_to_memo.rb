class AddFromToMemo < ActiveRecord::Migration[6.0]
  def change
    add_column :memos, :from, :int
  end
end

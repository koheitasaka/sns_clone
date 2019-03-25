class ChangeColumnToLikes < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :likes, :tweet_id, false, 0
  	change_column_null :likes, :user_id, false, 0
  	add_index :likes, [:tweet_id, :user_id], unique: true
  end
end

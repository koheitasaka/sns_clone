class AddStatusToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :status, :integer, default: 0
  end
end

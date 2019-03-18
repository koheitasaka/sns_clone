class RemoveImagesToUsers < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :images, :json
  end
end

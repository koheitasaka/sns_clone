class AddImagesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :images, :json
  end
end

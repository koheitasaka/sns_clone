class CreateInfomations < ActiveRecord::Migration[5.2]
  def change
    create_table :infomations do |t|
      t.references :user, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end

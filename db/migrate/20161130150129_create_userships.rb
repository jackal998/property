class CreateUserships < ActiveRecord::Migration[5.0]
  def change
    create_table :userships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps
    end
  end
end

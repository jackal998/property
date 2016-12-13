class CreateUserSubscribeships < ActiveRecord::Migration[5.0]
  def change
    create_table :user_subscribeships do |t|
      t.integer :user_id
      t.integer :obj_id
      t.timestamps
    end
  end
end

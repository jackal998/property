class AddIndexAndAddScheduleTimeToObj < ActiveRecord::Migration[5.0]
  def change
    change_column :userships, :user_id, :integer, :index => true
    change_column :userships, :friend_id, :integer, :index => true

    change_column :user_subscribeships, :user_id, :integer, :index => true
    change_column :user_subscribeships, :obj_id, :integer, :index => true

    change_column :user_likeships, :user_id, :integer, :index => true
    change_column :user_likeships, :obj_id, :integer, :index => true

    add_column :objs, :schedule_public, :datetime, :default => 0
  end
end

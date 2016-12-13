class ChangeSchedulePublicDefaultToNil < ActiveRecord::Migration[5.0]
  def change
    change_column :objs, :schedule_public, :datetime, :default => nil
  end
end

class ChangeSchedulePublicDefaultTo19000101 < ActiveRecord::Migration[5.0]
  def change
    change_column :objs, :schedule_public, :datetime, :default => '1900-01-01'
  end
end

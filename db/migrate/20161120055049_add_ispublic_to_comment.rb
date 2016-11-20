class AddIspublicToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :ispublic, :boolean, :default => true
  end
end

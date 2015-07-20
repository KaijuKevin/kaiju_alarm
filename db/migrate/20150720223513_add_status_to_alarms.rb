class AddStatusToAlarms < ActiveRecord::Migration
  def change
    add_column :alarms, :active, :boolean, :default => true
  end
end

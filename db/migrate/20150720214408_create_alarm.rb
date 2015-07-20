class CreateAlarm < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.string :to
      t.string :from
      t.string :body
      t.string :kaiju
      t.string :location

      t.timestamps
    end
  end
end

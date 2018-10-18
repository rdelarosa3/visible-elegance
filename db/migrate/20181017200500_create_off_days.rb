class CreateOffDays < ActiveRecord::Migration[5.2]
  def change
    create_table :off_days do |t|
      t.integer :day_off

      t.timestamps
    end
  end
end
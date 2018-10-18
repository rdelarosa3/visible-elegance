class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :off_day, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
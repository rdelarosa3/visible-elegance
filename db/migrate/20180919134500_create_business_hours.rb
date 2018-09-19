class CreateBusinessHours < ActiveRecord::Migration[5.2]
  def change
    create_table :business_hours do |t|
      t.references :business, foreign_key: true
      t.integer :day
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end
end

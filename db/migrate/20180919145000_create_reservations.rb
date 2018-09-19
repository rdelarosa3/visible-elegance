class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :service, foreign_key: true
      t.date :reservation_date
      t.time :reservation_time
      t.text :notes

      t.timestamps
    end
  end
end

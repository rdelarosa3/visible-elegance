class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :service, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.date :reservation_date
      t.time :reservation_time
      t.time :end_time
      t.text :notes

      t.timestamps
    end
  end
end

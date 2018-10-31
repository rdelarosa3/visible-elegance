class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :email, null: false
      t.string :gender
      t.date :birthday
      t.string :phone_number
      t.integer :role, default: 0
      t.references :title, foreign_key: true
      t.string :instagram
      t.string :facebook
      t.string :linkedin
      t.string :avatar
      t.text :notes
      t.string :password_digest

      t.timestamps
    end
  end
end


class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.references :service_type, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.integer :length

      t.timestamps
    end
  end
end

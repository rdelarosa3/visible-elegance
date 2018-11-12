class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :advert
      t.timestamps
    end
  end
end
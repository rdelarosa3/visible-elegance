class AddColumn < ActiveRecord::Migration[5.2]
  def change
   	add_column :reservations, :status, :integer, default: 0
   	add_column :reservations, :stylist_id, :integer
  end
end
class AddRedeemed < ActiveRecord::Migration[5.2]
  def change
   	add_column :stamps, :redeemed, :boolean
  end
end
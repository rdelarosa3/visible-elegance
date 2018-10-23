class AddStamper < ActiveRecord::Migration[5.2]
  def change
   	add_column :stamps, :stamper_id, :integer
  end
end
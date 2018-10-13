class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.references :user, index: true
      t.references :service, index: true
      t.timestamps
    end
  end
end
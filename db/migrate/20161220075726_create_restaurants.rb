class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :chain
      t.string :url
      t.string :information
      t.string :download_identifier

      t.timestamps
    end
  end
end

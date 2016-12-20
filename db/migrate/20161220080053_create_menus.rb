class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
			t.belongs_to :restaurant, index: true
      t.date :date
      t.string :language, limit: 2
      t.string :lunch_time

      t.timestamps
    end
   
    add_foreign_key :menus, :restaurants, on_delete: :cascade
  	add_index :menus, [:restaurant_id, :date, :language], :unique => true
  end
end

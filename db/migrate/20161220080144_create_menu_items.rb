class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
			t.belongs_to :menu, index: true
      t.string :name, null: false
      t.string :price
      t.text :components
      t.string :information
      t.integer :weight, default: 0

      t.timestamps
    end
    
    add_foreign_key :menu_items, :menus, on_delete: :cascade
  end
end

class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
			t.belongs_to :list, index: true
			t.belongs_to :restaurant, index: true
    	t.integer :weight, default: 0

      t.timestamps
    end

    add_foreign_key :listings, :lists, on_delete: :cascade
    add_foreign_key :listings, :restaurants, on_delete: :cascade
  end
end

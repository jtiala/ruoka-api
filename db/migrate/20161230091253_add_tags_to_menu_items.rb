class AddTagsToMenuItems < ActiveRecord::Migration[5.0]
  def change
		add_column :menu_items, :tags, :text
		change_column :menu_items, :name, :string, :null => true
	end
end

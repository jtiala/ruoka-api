class MenuItemSerializer < ActiveModel::Serializer
	belongs_to :menu, key: :menu_id
  
  attributes :id, :name, :price, :components, :information, :weight

  def menu
  	object.menu.id
	end

	def components
		JSON.parse(object.components)
	end
end

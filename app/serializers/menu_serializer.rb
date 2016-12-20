class MenuSerializer < ActiveModel::Serializer
	belongs_to :restaurant, key: :restaurant_id
	has_many :menu_items
 
 	attributes :id, :date, :language, :lunch_time

 	def restaurant 
 		object.restaurant.id
	end
end

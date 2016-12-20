class RestaurantSerializer < ActiveModel::Serializer
	has_many :menus
	
 	attributes :id, :name, :chain, :url, :information
end

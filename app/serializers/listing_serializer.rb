class ListingSerializer < ActiveModel::Serializer
	belongs_to :list, key: :list_id
	belongs_to :restaurant, key: :restaurant_id
  attributes :id, :weight

  def list
  	object.list.id
	end
	
	def restaurant
		object.restaurant.id
	end
end

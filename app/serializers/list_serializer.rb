class ListSerializer < ActiveModel::Serializer
	has_many :restaurants

	attributes :id, :name
end

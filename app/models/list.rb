class List < ApplicationRecord
	has_many :listings
	has_many :restaurant, through: :listing
end

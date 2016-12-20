class List < ApplicationRecord
	has_many :listings
	has_many :restaurants, through: :listings
end

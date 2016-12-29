class List < ApplicationRecord
	has_many :listings
	has_many :restaurants, -> { order(:chain, :name) }, through: :listings 
end

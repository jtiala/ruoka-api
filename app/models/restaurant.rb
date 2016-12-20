class Restaurant < ApplicationRecord
	has_many :listings
	has_many :lists, through: :listing
	has_many :menus
end

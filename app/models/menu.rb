class Menu < ApplicationRecord
	belongs_to :restaurant
	has_many :menu_items, -> { order(:weight, :id) }
end

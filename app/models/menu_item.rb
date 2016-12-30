class MenuItem < ApplicationRecord
	belongs_to :menu
	serialize :components, JSON
	serialize :tags, JSON
end

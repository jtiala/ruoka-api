FactoryGirl.define do
  factory :menu_item do
    name "Menu Item"
    price "2,60 €"
    components '[{name: "Food 1"},{name: "Food 2"}]'
    information "Additional info"
    weight 1
  end
end

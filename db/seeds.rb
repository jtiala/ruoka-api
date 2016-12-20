# Lists

lists = [
	{:name => 'Linnanmaa'},
	{:name => 'Keskusta'},
	{:name => 'Kontinkangas & Kaukovainio'},
	{:name => 'Teknologiakylä'}
]

lists.each do |list|
	unless List.exists?(:name => list[:name])
		List.create(list)
	end
end

# Restaurants

restaurants = []

amica_restaurants = [
	{
		:name => 'Central Station',
		:chain => 'Amica',
		:download_identifier => '0273'
	},
	{
		:name => 'Stories',
		:chain => 'Amica',
		:download_identifier => '0274'
	},
	{
		:name => 'Datagarage',
		:chain => 'Amica',
		:download_identifier => '0275'
	},
	{
		:name => 'Aava',
		:chain => 'Amica',
		:download_identifier => '0271'
	},
	{
		:name => 'ODL Kantakortteli',
		:chain => 'Amica',
		:download_identifier => '1694'
	},
	{
		:name => 'Alwari',
		:chain => 'Amica',
		:download_identifier => '0226'
	},
	{
		:name => 'Kotkanpoika & Kultturelli',
		:chain => 'Amica',
		:download_identifier => '0235'
	},
	{
		:name => 'Smarthouse',
		:chain => 'Amica',
		:download_identifier => '3498'
	},
	{
		:name => 'Garden',
		:chain => 'Amica',
		:download_identifier => '3497'
	}
]

restaurants.concat amica_restaurants

restaurants.each do |restaurant|
	r = Restaurant.where(:name => restaurant[:name]).first
	unless r
		Restaurant.create(restaurant)
	else
		restaurant.delete(:name)
		r.update(restaurant)
	end
end

# Listings

listings = {
	"Linnanmaa" => [
		"Central Station",
		"Stories",
		"Datagarage",
		"Aava",
		"Balance"
	],
	"Keskusta" => [
		"ODL Kantakortteli"
	],
	"Kontinkangas & Kaukovainio" => [
		"Alwari",
		"Kotkanpoika & Kultturelli"
	],
	"Teknologiakylä" => [
		"Smarthouse",
		"Garden"
	]
}

listings.each do |list_name, restaurants|
	if list = List.find_by_name(list_name)
		restaurants.each_with_index do |restaurant_name, index|
			if restaurant = Restaurant.find_by_name(restaurant_name)
				l = Listing.where({list: list, restaurant: restaurant}).first
				unless l
					Listing.create({list: list, restaurant: restaurant, weight: index})
				else
					l.update({weight: index})
				end
			end
		end
	end
end

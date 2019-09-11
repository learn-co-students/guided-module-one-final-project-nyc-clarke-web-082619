Location.destroy_all
PickupLine.destroy_all
User.destroy_all
Provider.destroy_all

#LOCATIONS

$hogwarts = Location.create(name: 'Hogwarts')
$mos_eisley_cantina = Location.create(name: 'Mos Eisley Cantina')
$gym = Location.create(name: 'The Gym')
$coffee_shop = Location.create(name: 'A Coffee Shop')
$dog_park = Location.create(name: 'The Dog Park')
$beach_pool = Location.create(name: 'The Beach or Pool')
$programming_meetup = Location.create(name: 'A Programming Meetup')
$dem_national_convention = Location.create(name: 'Democratic National Convention')
$bar = Location.create(name: 'A Bar')
$other_location = Location.create(name: 'Another Location')

#PROVIDERS
$chad = Provider.create(name: 'Chad', employed: true)
$tanner = Provider.create(name: 'Tanner', employed: true)
$braxton = Provider.create(name: 'Braxton', employed: true)
$brenadeigh = Provider.create(name: 'Brenadeigh', employed: true)
$kavaleigh = Provider.create(name: 'Kavaleigh', employed: true)
$deannalynn = Provider.create(name: 'DeAnnalynn', employed: true)

#USERS
$whiteclawjack = User.create(name: 'Jack', phone_number: '323-432-7612', active_user: true)
$andrew = User.create(name: 'Andrew', phone_number: '323-432-7613', active_user: true)
$xxreddarknessxx = User.create(name: 'Tony', phone_number: '323-432-7614', active_user: true)
$kayla = User.create(name: 'Kayla', phone_number: '323-432-7615', active_user: true)
$megan = User.create(name: 'Megan', phone_number: '323-432-7616', active_user: true)
$erin = User.create(name: 'Erin', phone_number: '323-432-7617', active_user: true)

#PICKUP-LINES

$harry_potter.each do |line|
  PickupLine.create({content: line, location: $hogwarts})
end

$star_wars.each do |line|
  PickupLine.create({content: line, location: $mos_eisley_cantina})
end

$gyms.each do |line|
  PickupLine.create({content: line, location: $gym})
end 

$coffee_shops.each do |line|
  PickupLine.create({content: line, location: $coffee_shop})
end

$dog_parks.each do |line|
  PickupLine.create({content: line, location: $dog_park})
end

$beaches_pools.each do |line|
  PickupLine.create({content: line, location: $beach_pool})
end

$computers.each do |line|
  PickupLine.create({content: line, location: $programming_meetup})
end 

$political_events.each do |line|
  PickupLine.create({content: line, location: $dem_national_convention})
end

$bars.each do |line|
  PickupLine.create({content: line, location: $bar})
end

$is_your_daddy.each do |line|
  PickupLine.create({content: line, location: $other_location})
end


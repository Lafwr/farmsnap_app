puts "Seeding database..."

# Destroy existing records in the correct order
Like.destroy_all
Comment.destroy_all
Post.destroy_all
Crate.destroy_all  # ✅ Destroy crates first since they depend on farmers
EventAttendance.destroy_all
Event.destroy_all
Farmer.destroy_all
User.destroy_all
Category.destroy_all

# Create categories for events
categories = [
  "Seafood", "Dairy", "Meats", "Organic", "Halal", "Fruit & Veg", "Baked Goods", "Alcohols", "Warm Food"
].map { |name| Category.create!(name: name) }

# Step 1: Create Users (for Farmers)
users = []
10.times do |i|
  users << User.create!(
    email: "farmer#{i + 1}@farmsnap.com",
    password: "password",
    first_name: "Firstname#{i + 1}",
    last_name: "Lastname#{i + 1}",
    username: "username#{i + 1}"
  )
end

# Step 2: Create Farmers
farmers = []
farmers_data = [
  { name: "Ali Khan", location: "Hertfordshire, UK" },
  { name: "Emma Davis", location: "Surrey, UK" },
  { name: "Liam Johnson", location: "Kent, UK" },
  { name: "Sophia Wilson", location: "Essex, UK" },
  { name: "Noah Brown", location: "Hampshire, UK" },
  { name: "Olivia Martinez", location: "Berkshire, UK" },
  { name: "James Anderson", location: "Norfolk, UK" },
  { name: "Charlotte Lee", location: "Oxfordshire, UK" },
  { name: "Benjamin Harris", location: "Gloucestershire, UK" },
  { name: "Mia Walker", location: "Cambridgeshire, UK" }
]

farmers_data.each_with_index do |farmer, index|
  farmer_record = Farmer.create!(
    user: users[index],
    name: farmer[:name], # Oskar ADDED
    bio: "#{farmer[:name]} is a skilled farmer.",
    location: farmer[:location]
  )
  farmers << farmer_record
end

# Step 3: Create Events (Markets) - Assign a Farmer to Each Event
events_data = [
  { name: "Borough Market", location: "8 Southwark St, London SE1 1TL", start_time: "08:00", end_time: "17:00", categories: ["Seafood", "Dairy", "Meats", "Organic", "Fruit & Veg", "Baked Goods", "Warm Food"] },
  { name: "Spitalfields Market", location: "56 Brushfield St, London E1 6AA", start_time: "09:00", end_time: "18:00", categories: ["Organic", "Baked Goods", "Fruit & Veg"] },
  { name: "Portobello Road Market", location: "Portobello Rd, London W11 1LJ", start_time: "09:00", end_time: "16:00", categories: ["Meats", "Seafood", "Warm Food", "Baked Goods"] },
  { name: "Camden Market", location: "Camden Lock Pl, London NW1 8AF", start_time: "10:00", end_time: "19:00", categories: ["Warm Food", "Alcohols"] },
  { name: "Greenwich Market", location: "5B Greenwich Market, London SE10 9HZ", start_time: "10:00", end_time: "17:30", categories: ["Organic", "Dairy", "Baked Goods"] },
  { name: "Broadway Market", location: "Broadway Market, London E8 4PH", start_time: "09:00", end_time: "17:00", categories: ["Fruit & Veg", "Meats", "Seafood"] },
  { name: "Brick Lane Market", location: "91 Brick Ln, London E1 6QR", start_time: "10:00", end_time: "17:00", categories: ["Warm Food", "Organic", "Baked Goods"] },
  { name: "Columbia Road Flower Market", location: "Columbia Rd, London E2 7RG", start_time: "08:00", end_time: "15:00", categories: ["Fruit & Veg", "Dairy"] },
  { name: "Southbank Centre Market", location: "Southbank Centre, Belvedere Rd, London SE1 8XX", start_time: "11:00", end_time: "20:00", categories: ["Warm Food", "Alcohols", "Baked Goods"] },
  { name: "Maltby Street Market", location: "41 Maltby St, London SE1 3PA", start_time: "10:00", end_time: "18:00", categories: ["Meats", "Seafood", "Baked Goods"] },
  { name: "Hackney Flea Market", location: "Amhurst Terrace, London E8 2BT", start_time: "09:00", end_time: "17:00", categories: ["Baked Goods", "Organic", "Fruit & Veg"] },
  { name: "Peckham Farmers' Market", location: "Peckham Square, London SE15 5JT", start_time: "10:00", end_time: "16:00", categories: ["Meats", "Seafood", "Fruit & Veg"] },
  { name: "Walthamstow Market", location: "High St, London E17 7LD", start_time: "08:30", end_time: "17:30", categories: ["Dairy", "Warm Food", "Organic"] },
  { name: "Brixton Market", location: "Electric Ave, London SW9 8JY", start_time: "08:00", end_time: "18:00", categories: ["Seafood", "Warm Food", "Fruit & Veg"] }
]


events = []
events_data.each_with_index do |event, index|
  event_record = Event.create!(
    name: event[:name],
    location: event[:location],
    start_time: event[:start_time],
    end_time: event[:end_time],
    farmer: farmers[index % farmers.length] # ✅ Assign a farmer to the event
  )
  event_record.categories << Category.where(name: event[:categories])
  events << event_record
end

event_attendances = []

# Define structured time increments
REALISTIC_TIMES = ["00", "15", "30", "45"] # Round minutes

events.each do |event|
  attending_farmers = farmers.sample(rand(4..7)) # Each event gets 4-7 farmers

  attending_farmers.each do |farmer|
    # Farmers arrive at event start time or within the first 30 minutes
    start_hour = event.start_time.to_time.hour
    start_minute = ["00", "15", "30"].sample # Arrives on the hour, quarter, or half-past
    adjusted_start = "#{start_hour}:#{start_minute}"

    # Farmers stay for 60% to 80% of the event duration
    event_duration = (event.end_time.to_time - event.start_time.to_time) # In seconds
    min_stay = (event_duration * 0.6).to_i # At least 60% of event duration
    max_stay = (event_duration * 0.8).to_i # Up to 80% of event duration
    adjusted_end_time = event.start_time.to_time + rand(min_stay..max_stay)

    # Ensure they leave at the event’s end time or earlier
    adjusted_end_hour = [event.end_time.to_time.hour, adjusted_end_time.hour].min
    adjusted_end_minute = REALISTIC_TIMES.sample # Quarter, half-past, etc.
    adjusted_end = "#{adjusted_end_hour}:#{adjusted_end_minute}"

    event_attendances << EventAttendance.create!(
      farmer: farmer,
      event: event,
      start_time: adjusted_start,
      end_time: adjusted_end
    )
  end
end

puts "Seeding completed successfully!"

# Step 5: Create Crates (10x number of farmers)
total_crates_needed = farmers.length * 10
created_crates = 0

crate_names = [
  "Organic Veg Box", "Dairy Selection", "Egg Pack", "Grass-Fed Meat Box",
  "Seasonal Fruit Basket", "Baker’s Special", "Gourmet Cheese Set", "Herbal Tea Collection",
  "Artisan Honey & Jam", "Raw Honey Selection", "Freshly Picked Herbs", "Wildflower Bouquet",
  "Cold-Pressed Juice Pack", "Handmade Pasta Kit", "Organic Snack Sampler", "Locally Sourced Meat Pack",
  "Specialty Mushroom Box", "Heirloom Tomato Crate", "Root Vegetable Selection", "Farm Fresh Salad Kit"
]

unique_crate_names = crate_names.shuffle.first((total_crates_needed * 0.8).to_i) # 80% Unique
reused_crate_names = crate_names.shuffle.first((total_crates_needed * 0.2).to_i) # 20% Reused

crates = []
farmers.each do |farmer|
  num_crates = rand(5..15)
  num_flash_sales = rand(0..[5, num_crates].min)
  crate_list = unique_crate_names.shift(num_crates) + reused_crate_names.sample([0, num_crates - unique_crate_names.length].max)

  crate_list.each_with_index do |crate_name, index|
    break if created_crates >= total_crates_needed

    current_event = farmer.event_attendances.order(start_time: :desc).first&.event
    location = current_event ? current_event.location : farmer.location

    new_crate = Crate.create!(
      farmer: farmer,
      name: "#{crate_name}",
      description: "A selection of premium farm products from #{farmer.user.first_name}'s farm.",
      price: rand(5.00..50.00).round(2),
      flash_sale: index < num_flash_sales
    )

    # ✅ Ensure crates get geocoded dynamically
    geocoded = Geocoder.search(location).first
    if geocoded
      new_crate.update(latitude: geocoded.latitude, longitude: geocoded.longitude)
    end


    crates << new_crate
    created_crates += 1
  end
end

# POSTS COMMENTS AND LIKES

farmers.each do |farmer|
  3.times do
    post = Post.create!(
      farmer: farmer,
      caption: "Check out my farm's latest updates! 🌾"
    )

    # Add likes from random users
    users.sample(3).each do |user|
      Like.create!(user: user, post: post)
    end

    # Add comments from random users
    users.sample(3).each do |user|
      Comment.create!(user: user, post: post, content: "Amazing post, #{farmer.name}!")
    end
  end
end
puts "Social posts, comments and likes loaded..."




# Step 4: Assign Event Attendances
# farmers.each do |farmer|
#   available_events = events.sample(5) # Each farmer attends up to 5 events

#   available_events.each do |event|
#     EventAttendance.create!(
#       farmer: farmer,
#       event: event,
#       start_time: event.start_time,
#       end_time: event.end_time
#     )
#   end
# end

puts "Seeding completed successfully!"

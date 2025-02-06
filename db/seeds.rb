require "open-uri"
require "faker"
# require "pry"
puts "Seeding database..."

# Destroy existing records in the correct order
Like.destroy_all
Comment.destroy_all
Post.destroy_all
Crate.destroy_all  # ✅ Destroy crates first since they depend on farmers
EventAttendance.destroy_all
Event.destroy_all
Review.destroy_all
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
    first_name: Faker::Name.name.split(" ").first,
    last_name: Faker::Name.name.split(" ").second,
    username: "username#{i + 1}"
  )
end

# Step 2: Create Farmers
farmers = []
farmers_data = [
  { name: "Ali Khan", location: "Hertfordshire, UK", url: "https://randomuser.me/api/portraits/men/48.jpg" },
  { name: "Emma Davis", location: "Surrey, UK", url: "https://t4.ftcdn.net/jpg/06/01/86/55/360_F_601865599_IuuZWat7GqziLoF5tfXG8Ify96xH1pRr.jpg"},
  { name: "Liam Johnson", location: "Kent, UK", url: "https://media.istockphoto.com/id/1269841295/photo/side-view-of-a-senior-farmer-standing-in-corn-field-examining-crop-at-sunset.jpg?s=612x612&w=0&k=20&c=Lheldd6VVGQGxrgC8_mwUTLxXGg9v8Y6abjmYLhLHug="},
  { name: "Sophia Wilson", location: "Essex, UK", url: "https://media.istockphoto.com/id/1321487999/photo/female-farmer-or-agronomist-examining-green-soybean-plants-in-field.jpg?s=612x612&w=0&k=20&c=qZlBSldnMpr3dm14QpGi_ZqekoqofcVW19g4Rbo7jqg=" },
  { name: "Noah Brown", location: "Hampshire, UK", url: "https://thefoodgroupmn.org/wp-content/uploads/2022/08/296TerraSuraPhotography-BigRiverFarms5x7-0984.jpg" },
  { name: "Olivia Martinez", location: "Berkshire, UK", url: "https://media.istockphoto.com/id/1329208436/photo/mature-latin-woman-holding-fresh-eggs-elderly-farmer-person-smiling-in-camera.jpg?s=612x612&w=0&k=20&c=cHzVKc2IhZAk9UUsckAx6JNwh-LOMk-6aR5VWSb77og="},
  { name: "James Anderson", location: "Norfolk, UK", url: "https://spotlights.dtnpf.com/innovations/assets/images/HeathWhitmore_3.jpg" },
  { name: "Charlotte Lee", location: "Oxfordshire, UK", url: "https://media.istockphoto.com/id/538889138/photo/african-woman-laughing.jpg?s=612x612&w=0&k=20&c=OJTMbnqP8x9v-Ly2KyXD_MGWMoEbJDcdcTX0Lc2dock=" },
  { name: "Benjamin Harris", location: "Gloucestershire, UK", url: "https://t3.ftcdn.net/jpg/06/34/21/18/360_F_634211884_Rg63xefg07sO79viofi4mlyP74VYPClq.jpg" },
  { name: "Mia Walker", location: "Cambridgeshire, UK", url: "https://t4.ftcdn.net/jpg/06/36/88/55/360_F_636885527_MgSULmWt6vIinD9j1J4blMDCCaDVvF6v.jpg"}
]

farmers_data.each_with_index do |farmer, index|
  farmer_record = Farmer.new(
    user: users[index],
    name: farmer[:name], # Oskar ADDED
    bio: "#{farmer[:name]} is a passionate farmer growing fresh, sustainable produce with love and dedication on aour family farm.",
    location: farmer[:location]
  )
  file = URI.parse(farmer[:url]).open
  farmer_record.photo.attach(io: file, filename: "profile-pic", content_type: "image/jpg")
  farmer_record.save!
  farmers << farmer_record
end

# Step 3: Create Events (Markets) - Assign a Farmer to Each Event
events_data = [
  { name: "Borough Market", location: "8 Southwark St, London SE1 1TL", start_time: "08:00", end_time: "17:00", categories: ["Seafood", "Dairy", "Meats", "Organic", "Fruit & Veg", "Baked Goods", "Warm Food"], url: "https://offloadmedia.feverup.com/secretldn.com/wp-content/uploads/2023/04/25124446/shutterstock_736291438-2-666x374.jpg"},
  { name: "Spitalfields Market", location: "56 Brushfield St, London E1 6AA", start_time: "09:00", end_time: "18:00", categories: ["Organic", "Baked Goods", "Fruit & Veg"], url: "https://www.cktravels.com/wp-content/uploads/2023/02/london-farmers-markets.jpg" },
  { name: "Portobello Road Market", location: "Portobello Rd, London W11 1LJ", start_time: "09:00", end_time: "16:00", categories: ["Meats", "Seafood", "Warm Food", "Baked Goods"], url: "https://www.cktravels.com/wp-content/uploads/2023/02/london-farmers-markets.jpg" },
  { name: "Camden Market", location: "Camden Lock Pl, London NW1 8AF", start_time: "10:00", end_time: "19:00", categories: ["Warm Food", "Alcohols"], url: "https://www.southwesternrailway.com/-/media/images/content-images/where-next/things-to-do/2022/april/farmers-markets/farmers-markets-body-image-hampshire.jpg" },
  { name: "Greenwich Market", location: "5B Greenwich Market, London SE10 9HZ", start_time: "10:00", end_time: "17:30", categories: ["Organic", "Dairy", "Baked Goods"], url: "https://www.swlondoner.co.uk/wp-content/uploads/2020/09/Teds-Veg-PG-opening-day-3000-pixels.jpg" },
  { name: "Broadway Market", location: "Broadway Market, London E8 4PH", start_time: "09:00", end_time: "17:00", categories: ["Fruit & Veg", "Meats", "Seafood"], url: "https://www.cktravels.com/wp-content/uploads/2023/02/london-farmers-markets.jpg" },
  { name: "Brick Lane Market", location: "91 Brick Ln, London E1 6QR", start_time: "10:00", end_time: "17:00", categories: ["Warm Food", "Organic", "Baked Goods"], url: "https://mediaproxy.salon.com/width/1200/https://media2.salon.com/2021/08/farmers-market-produce-0812211.jpg" },
  { name: "Columbia Road Flower Market", location: "Columbia Rd, London E2 7RG", start_time: "08:00", end_time: "15:00", categories: ["Fruit & Veg", "Dairy"], url: "https://www.cktravels.com/wp-content/uploads/2023/02/london-farmers-markets.jpg" },
  { name: "Southbank Centre Market", location: "Southbank Centre, Belvedere Rd, London SE1 8XX", start_time: "11:00", end_time: "20:00", categories: ["Warm Food", "Alcohols", "Baked Goods"], url: "https://foodtank.com/wp-content/uploads/2024/07/American-Farmland-Trust-Americas-Farmers-Market-Celebration-farmers-markets-local-food.jpg" },
  { name: "Maltby Street Market", location: "41 Maltby St, London SE1 3PA", start_time: "10:00", end_time: "18:00", categories: ["Meats", "Seafood", "Baked Goods"], url: "https://res.cloudinary.com/dguhp96ik/image/upload/v1722616860/JAZ_5214_5704c4f849.jpg" },
  { name: "Hackney Flea Market", location: "Amhurst Terrace, London E8 2BT", start_time: "09:00", end_time: "17:00", categories: ["Baked Goods", "Organic", "Fruit & Veg"], url: "https://img1.10bestmedia.com/Images/Photos/404621/GettyImages-1422148652_55_660x440.jpg" },
  { name: "Peckham Farmers' Market", location: "Peckham Square, London SE15 5JT", start_time: "10:00", end_time: "16:00", categories: ["Meats", "Seafood", "Fruit & Veg"], url: "https://ediblerenotahoe.com/wp-content/uploads/2024/05/AdobeStock_608139476.png" },
  { name: "Walthamstow Market", location: "High St, London E17 7LD", start_time: "08:30", end_time: "17:30", categories: ["Dairy", "Warm Food", "Organic"], url: "https://www.thepublicdiscourse.com/wp-content/uploads/2021/03/AdobeStock_159794400-1024x682.jpeg" },
  { name: "Brixton Market", location: "Electric Ave, London SW9 8JY", start_time: "08:00", end_time: "18:00", categories: ["Seafood", "Warm Food", "Fruit & Veg"], url: "https://d27p2a3djqwgnt.cloudfront.net/wp-content/uploads/2017/10/19050002/market-1558658_1280-e1508344545263.jpg" }
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
  file = URI.parse(event[:url]).open
  event_record.photo.attach(io: file, filename: "event-pic", content_type: "image/jpg")
  event_record.save!
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
      flash_sale: index < num_flash_sales,
      event: farmer.events.shuffle.first
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


reviews = [
  { rating: 5, content: "Excellent service and top-quality produce!" },
  { rating: 4, content: "Great experience, but delivery took a bit long." },
  { rating: 3, content: "Average quality, expected better." },
  { rating: 5, content: "Absolutely amazing! Fresh and organic products." },
  { rating: 2, content: "Not satisfied. The vegetables were not fresh." },
  { rating: 4, content: "Good quality, but a bit expensive." },
  { rating: 1, content: "Poor service, would not recommend." },
  { rating: 5, content: "Best farm produce I’ve ever had!" },
  { rating: 3, content: "It was okay, nothing special." },
  { rating: 4, content: "Fresh fruits, but the packaging needs improvement." }
]

farmers = Farmer.all
farmers.each do |farmer|
  3.times do
    review = Review.new(reviews.sample)
    review.user = User.all.sample
    review.farmer = farmer
    review.save!
  end
end

# farmer = Farmer.first # Pick any farmer
# users = User.pluck(:id) # Get all user IDs

# reviews.each do |review|
#   farmer.reviews.create!(review.merge(user_id: users.sample))
# end


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

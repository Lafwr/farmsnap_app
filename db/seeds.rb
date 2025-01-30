puts "Seeding database..."

# Destroy existing records in the correct order
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
    first_name: "Farmer#{i + 1}",
    last_name: "Lastname#{i + 1}",
    username: "farmer#{i + 1}"
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
    user: users[index], # ✅ Ensuring farmer is linked to a user
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
  { name: "Camden Market", location: "Camden Lock Pl, London NW1 8AF", start_time: "10:00", end_time: "19:00", categories: ["Warm Food", "Alcohols"] }
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

# Step 4: Assign Event Attendances
farmers.each do |farmer|
  available_events = events.sample(5) # Each farmer attends up to 5 events

  available_events.each do |event|
    EventAttendance.create!(
      farmer: farmer,
      event: event,
      start_time: event.start_time,
      end_time: event.end_time
    )
  end
end

puts "Seeding completed successfully!"

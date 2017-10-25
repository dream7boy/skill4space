require "faker"

puts 'Cleaning database...'
User.destroy_all

puts 'Creating database...'

10.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    is_owner: true,
    address: ["Meguro Station, Shinagawa, Tokyo", "Tokyo Station, Chiyoda, Tokyo", "Shinjuku Station, 3 Chome Shinjuku, Tokyo"].sample
    )

  3.times do
    skill = Skill.create!(
      skill_category: Faker::Job.field,
      user_id: user.id
      )
  end

  if user.is_owner
    3.times do
      start_random_date = DateTime.new(2017, 11, rand(6..8))
      space = Space.create!(
        name: Faker::Company.name,
        category: ["Garage", "Kitchen", "Office", "Design studio", "Coworking", "Classroom", "Laboratory"].sample,
        # category: ["Chincilla", "Crocodile", "Wallaby", "Chameleon", "Capybara", "Fennec", "Hedgehog"].sample,
        start_date: start_random_date,
        end_date: start_random_date + rand(1..2),
        daily_price: rand(5000..20000).round(-3),
        is_barter: [true, false].sample,
        user_id: user.id,
        city: "Tokyo",
        address: user.address
        )
    end
  end
end

      # photo_urls = {
      #   "Chincilla" => "http://www.wordsiseek.com/wp-content/uploads/2017/10/Chinchilla.png",
      #   "Crocodile" => "https://cdnimg.in/wp-content/uploads/2016/04/c5.jpg?2bbdf3",
      #   "Wallaby" => "https://s3.amazonaws.com/media.ohi/15878_wallabyf.jpeg",
      #   "Chameleon" => "http://i.imgur.com/Vjscc7j.jpg",
      #   "Capybara" => "https://a.dilcdn.com/bl/wp-content/uploads/sites/8/2013/05/capybara-08.jpg",
      #   "Fennec" => "https://pbs.twimg.com/media/DGvGKfSXgAA5USU.jpg",
      #   "Hedgehog" => "https://www.thesun.co.uk/wp-content/uploads/2017/05/nintchdbpict000321400090.jpg?strip=all&w=960"
      # }

      # pet.remote_photo_url = photo_urls[pet.species]
      # pet.save

5.times do
  # start_random_date = DateTime.new(2017, 11, rand(6..8))
  booked_space = Space.order("RANDOM()").first
  booked_days = booked_space.end_date - booked_space.start_date + 1

  booking = Booking.create!(
    total_price: booked_days * booked_space.daily_price,
    status: ["Pending", "Confirmed"].sample,
    start_date: booked_space.start_date,
    end_date: booked_space.end_date,
    user_id: User.first.id,
    space_id: booked_space.id
    )
end

puts 'Finished!'

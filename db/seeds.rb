require "faker"

puts 'Cleaning database...'
User.destroy_all

puts 'Creating database...'

6.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    is_owner: true,
    address: ["Meguro Station, Tokyo", "Tokyo Station, Tokyo", "Shinjuku Station, Tokyo", "Ginza, Tokyo", "Shiodome, Tokyo"].sample
    )

  3.times do
    skill = Skill.create!(
      skill_category: ["Cooking", "Cleaning", "Design", "Music", "Dance", "Teaching", "Coding", "Farming"].sample,
      user_id: user.id
      )
  end

  if user.is_owner
    3.times do
      # start_random_date = DateTime.new(2017, 11, rand(6..8))
      space = Space.create!(
        name: Faker::Company.name,
        category: ["Garage", "Kitchen", "Office", "Design studio", "Coworking"].sample,
        # category: ["Garage", "Kitchen", "Office", "Design studio", "Coworking", "Classroom", "Laboratory"].sample,
        # category: ["Chincilla", "Crocodile", "Wallaby", "Chameleon", "Capybara", "Fennec", "Hedgehog"].sample,
        start_date: DateTime.new(2017, 11, 6),
        end_date: DateTime.new(2017, 11, 10),
        # start_date: start_random_date,
        # end_date: start_random_date + rand(1..2),
        opening_hours: Time.new(2017, 10, 31, 9, 0, 0),
        closing_hours: Time.new(2017, 10, 31, 17, 0, 0),
        daily_price: rand(5000..20000).round(-3),
        is_barter: [true, false].sample,
        user_id: user.id,
        city: "Tokyo",
        address: user.address
        )

      if space.is_barter == true
        space.required_skill = ["Cooking", "Cleaning", "Design", "Music", "Dance", "Teaching", "Coding", "Farming"].sample
        space.save!
      end

      # skill_match = {
      #   "Office" => "Coding"
      # }


      photo_urls = {
        "Office" => ["app/assets/images/Office4.jpg"],
        "Coworking" => ["app/assets/images/Coworking4.jpg"],
        "Design studio" => ["app/assets/images/dstudio4.jpg"],
        "Kitchen" => ["app/assets/images/kitchen4.jpg"],
        "Garage" => ["app/assets/images/garage4.jpg"]
      }

      # photo_urls = {
      #   "Office" => ["app/assets/images/Office1.jpg",
      #     "app/assets/images/Office2.jpg",
      #     "app/assets/images/Office3.jpg",
      #     "app/assets/images/Office4.jpg"],
      #   "Coworking" => ["app/assets/images/Coworking1.jpg",
      #     "app/assets/images/Coworking2.jpg",
      #     "app/assets/images/Coworking3.jpg",
      #     "app/assets/images/Coworking4.jpg"],
      #   "Design studio" => ["app/assets/images/dstudio1.jpg",
      #     "app/assets/images/dstudio2.jpg",
      #     "app/assets/images/dstudio3.jpg",
      #     "app/assets/images/dstudio4.jpg"],
      #   "Kitchen" => ["app/assets/images/kitchen1.jpg",
      #     "app/assets/images/kitchen2.jpg",
      #     "app/assets/images/kitchen3.jpg",
      #     "app/assets/images/kitchen4.jpg"],
      #   "Garage" => ["app/assets/images/garage1.jpg",
      #     "app/assets/images/garage2.jpg",
      #     "app/assets/images/garage3.jpg",
      #     "app/assets/images/garage4.jpg"]
      # }


      # photo_urls = {
      #   "Office" => ["https://www.designboom.com/wp-content/uploads/2016/08/airbnb-tokyo-office-interiors-japan-suppose-design-office-designboom-11.jpg",
      #     "https://i.pinimg.com/736x/89/69/e5/8969e5a0046eeb3f2af4d2c45cd678a2--startup-office-office-office.jpg",
      #     "http://www.dialogdesign.ca/assets/UFA4.jpg"],
      #   "Coworking" => ["https://www.designboom.com/wp-content/uploads/2016/08/airbnb-tokyo-office-interiors-japan-suppose-design-office-designboom-02.jpg",
      #     "https://www.industriousoffice.com/wp-content/uploads/sites/2/2016/11/4-l-12-1024x512.jpg",
      #     "https://images.divisare.com/images/dpr_1.0,f_auto,q_auto,w_800/wxgzxj9ygn6o7hdxvqyf/pab-architects-habita-coworking-office.jpg"],
      #   "Design studio" => ["https://www.designboom.com/wp-content/uploads/2016/08/airbnb-tokyo-office-interiors-japan-suppose-design-office-designboom-07.jpg",
      #     "http://www.officedesigngallery.com/wp-content/uploads/2014/11/Uber-Headquarters-SF-Design-Office-7.jpg",
      #     "https://www.australiandesignreview.com/wp-content/uploads/2016/01/LL_N13.jpg"],
      #   "Kitchen" => ["https://www.designboom.com/wp-content/uploads/2016/08/airbnb-tokyo-office-interiors-japan-suppose-design-office-designboom-03.jpg",
      #     "https://i.pinimg.com/736x/53/14/02/5314023d855e4ab3511ef2210f1be889--restaurant-kitchen-design-luxury-kitchen-design.jpg",
      #     "https://i.pinimg.com/originals/04/81/25/0481252133f031d85f8f4deb3e101d3b.jpg"],
      #   "Garage" => ["http://cdn.wonderfulengineering.com/wp-content/uploads/2013/11/garage-organized-pic.jpg",
      #     "http://2.bp.blogspot.com/_xdtvkuj3Jaw/SxQnP8sArmI/AAAAAAAABQk/k8-qAigVow4/s640/1478EMountain_Garage.jpg",
      #     "http://architectural-design.info/wp-content/uploads/2015/02/garage-design.jpg"],
      #   "Classroom" => ["https://whatedsaid.files.wordpress.com/2010/10/classroom-1.jpg",
      #     "https://s3.amazonaws.com/libapps/accounts/34780/images/classroom_image.png",
      #     "http://lightingpatternsforhealthybuildings.org/assets/images/pattern_image/df6ad-sm_smallclassroom_redesign-2_full-output_view-1.jpg"],
      #   "Laboratory" => ["https://www.tue.nl/fileadmin/content/onderzoek/Onderzoekslabs/BvOF_TUe-labs_Cellab_webpagina.jpg",
      #     "https://medicine.dundee.ac.uk/sites/medicine.dundee.ac.uk/files/staff.JPG",
      #     "https://www.iaea.org/sites/default/files/styles/width_555px_6_units_16_9/public/16/12/jlt7935lowjpg/jlt7935low.jpg?itok=Y7rE9od2"]
      # }

      space.photo_urls = photo_urls[space.category]
      space.save!

      puts 'Photo seeding...'

    end
  end
end
      # pet.remote_photo_url = photo_urls[pet.species]
      # pet.save

      # url = "http://static.giantbomb.com/uploads/original/9/99864/
      # product = Product.new(name: 'NES')
      # product.remote_photo_url = url
      # product.save

3.times do
  # start_random_date = DateTime.new(2017, 11, rand(6..8))
  booked_space = Space.order("RANDOM()").first
  booked_days = booked_space.end_date - booked_space.start_date + 1

  booking = Booking.create!(
    total_price: booked_days * booked_space.daily_price,
    status: "Available",
    start_date: booked_space.start_date,
    end_date: booked_space.end_date,
    user_id: User.first.id,
    space_id: booked_space.id
    )
end

puts 'Finished!'

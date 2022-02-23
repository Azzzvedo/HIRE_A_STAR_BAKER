require 'faker'
require 'open-uri'

User.destroy_all


users = ['arrabella.stephenson@gmail.com', 'ian.wiggins@gmail.com', 'josh.walker@gmail.com', 'luz.valdovinos@gmail.com']
users.each do |user|
  name = user.split("@")[0].split(".")
  admin = User.create(first_name: name[0].capitalize, last_name: name[1].capitalize, email: user, password: "password", address: Faker::Address.street_address, baker: true)
  3.times do
    cake = Cake.new(
      name: "#{Faker::Movies::HarryPotter.spell} #{Faker::Dessert.variety}",
      price: rand(3..16),
      user: admin
    )
    file = URI.open('https://source.unsplash.com/random')
    cake.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    cake.save
  end
end

26.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123456',
    address: Faker::Address.street_address,
    baker: Faker::Boolean.boolean(true_ratio: 0.2)
  )

  if user.baker?
    3.times do
      cake = Cake.create!(
        name: "#{Faker::Movies::HarryPotter.spell} #{Faker::Dessert.variety}",
        price: rand(3..16),
        user: user
      )
      file = URI.open('https://source.unsplash.com/random')
      cake.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    end
  end
  puts "user #{user.id}"
end

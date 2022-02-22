require 'raker'
require 'open-uri'

50.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123456',
    address: Faker::Address.street_address,
    baker: Faker::Boolean.boolean(true_ratio: 0.2)
  )

  if user.baker?
    5.times do
      cake = Cake.create!(
        name: Faker::HarryPotter.spell,
        price: rand(3..16),
        user: user
      )
      file = URI.open('https://source.unsplash.com/random')
      cake.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    end
  end
end

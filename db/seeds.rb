require "open-uri"
require "nokogiri"
require 'faker'

User.destroy_all

SEASONS = (1..12).to_a

# COMMENT Baker first names

SEASONS.each do |season|
  url = "https://thegreatbritishbakeoff.co.uk/bakers/series-#{season}/"

  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search(".featured-block").each do |element|
    name = element.text.strip
    user = User.new(
      first_name: name,
      email: "#{name}@bake-off.com",
      password: '123456',
      address: Faker::Address.street_address,
      baker: true
    )
    file = URI.open(element.search('img').attribute("src"))
    user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    user.save!
  end
end

# COMMENT Baker recipe collection links
# COMMENT Baker recipe names

User.where(baker: true).each do |user|
  url = "https://thegreatbritishbakeoff.co.uk/recipes/"

  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search(".recipe-collection__item").each do |element|
    if element.search('h4').text.strip[-8..] == '\'s Bakes' && element.search('h4').text.strip[0..-8] == user.first_name
        cake = Cake.new(
          price: rand(8..16),
          user: user
        )
        url = element.search('a').attribute("href").value # recipe collection link

        html_file = URI.open(url).read
        html_doc = Nokogiri::HTML(html_file)

        html_doc.search(".recipes-loop__item").each do |element|
          cake[:name] = element.search('h5').text.strip # recipe name
          file = URI.open(element.search('img').attribute("src"))
          cake.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
          cake.save
        end

    end
  end
end

# users = ['arrabella.stephenson@gmail.com', 'ian.wiggins@gmail.com', 'josh.walker@gmail.com', 'luz.valdovinos@gmail.com']
# users.each do |user|
#   name = user.split("@")[0].split(".")
#   admin = User.create(first_name: name[0].capitalize, last_name: name[1].capitalize, email: user, password: "password", address: Faker::Address.street_address, baker: true)
#   3.times do
#     cake = Cake.new(
#       name: "#{Faker::Movies::HarryPotter.spell} #{Faker::Dessert.variety}",
#       price: rand(3..16),
#       user: admin
#     )
#     file = URI.open('https://source.unsplash.com/random')
#     cake.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
#     cake.save
#   end
# end

# 26.times do
#   user = User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: '123456',
#     address: Faker::Address.street_address,
#     baker: Faker::Boolean.boolean(true_ratio: 0.2)
#   )

#   if user.baker?
#     3.times do
#       cake = Cake.create!(
#         name: "#{Faker::Movies::HarryPotter.spell} #{Faker::Dessert.variety}",
#         price: rand(3..16),
#         user: user
#       )
#       file = URI.open('https://source.unsplash.com/random')
#       cake.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
#     end
#   end
#   puts "user #{user.id}"
# end

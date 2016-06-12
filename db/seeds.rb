# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create([{ name: 'Umbrella Man', password: 'good morning', is_admin: true}])

people = (0...50).map { Faker::Name.first_name.downcase }.uniq.map { |name| Tag.create(tag_type: 'people', name: name) }
categories = (0...10).map { Faker::Book.genre.downcase }.uniq.map { |name| Tag.create(tag_type: 'categories', name: name) }
photos = Dir["#{Rails.root}/spec/support/fixtures/photos/*.JPG"].map { |filename| File.new(filename) }

first_day = 500.days.ago

500.times do |number|
  day_people = people.sample(rand(5))
  day_categories = categories.sample(rand(3))
  day_photo_file = rand(10).zero? ? nil : photos.sample
  day_body = Faker::Lorem.paragraphs.join("\n\n")
  day_body = "[[youtube]](RdR-JSVQrVw) \n\n #{day_body}" if day_photo_file.nil?

  day = Day.create({
    title: Faker::Lorem.word.capitalize,
    number: number + 1,
    body: day_body,
    mouseover: Faker::StarWars.quote,
    lyrics: Faker::Book.title,
    lyric_credit: Faker::Book.author,
    whisper: "#{Faker::Superhero.power} #{number}",
    people: day_people,
    categories: day_categories,
    publish_date: first_day + number.days + rand(6).hours
  })

  Photo.create(photo: File.new(day_photo_file), day: day, is_canonical: true) unless day_photo_file.nil?
end

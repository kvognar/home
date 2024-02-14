# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ActiveRecord::Base.transaction do
  user = User.create([{ name: 'Umbrella Man', password: 'good morning', is_admin: true}])

  people_tag = Tag.create(name: 'people')
  people = (0...50).map { Faker::Name.name_with_middle.downcase }.uniq.map { |name| Tag.create!(parent: people_tag, name: name) }
  categories = (0...10).map { Faker::Book.genre.downcase }.uniq.map { |name| Tag.create!(name: name) }
  photos = Dir["#{Rails.root}/spec/support/fixtures/photos/*.JPG"].map { |filename| File.new(filename) }

  first_day = 500.days.ago

  works = []

  100.times do |number|
    work = MediaWork.create(
        title: Faker::Book.title,
        medium: MediaWork::MEDIUM_OPTIONS.sample,
        perennial: rand(100) < 20
        )
    works << work
  end

  puts 'starting days...'

  500.times do |number|
    day_people = people.sample(rand(5))
    day_categories = categories.sample(rand(3))
    day_photo_file = rand(10).zero? ? nil : photos.sample
    day_body = Faker::Lorem.paragraphs.join("\n\n")
    day_body = "[[youtube]](RdR-JSVQrVw) \n\n #{day_body}" if day_photo_file.nil?

    day = Day.create!({
      title: Faker::Lorem.word.capitalize,
      number: number + 1,
      body: day_body,
      mouseover: Faker::Games::Myst.quote,
      lyrics: Faker::Book.title,
      lyric_credit: Faker::Book.author,
      whisper: "#{Faker::Superhero.power} #{number}",
      tags: day_categories + day_people,
      publish_date: first_day + number.days + rand(6).hours
    })

    Photo.create(photo: File.new(day_photo_file), day: day, is_canonical: true) unless day_photo_file.nil?

    work = works.sample
    if work.media_consumptions.empty?
      work.media_consumptions.create(start_date: day.publish_date, state: 'in_progress')
    end
    consumption = work.media_consumptions.first
    consumption.media_sessions.create!(
        day: day,
        text: Faker::Lorem.paragraphs.join("\n\n"),
        spoiler_text: Faker::Lorem.paragraphs.join("\n\n")
    )
    puts day.number

  end
# end

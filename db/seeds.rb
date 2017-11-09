# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")
file = File.open("users_list.txt", "w")
def seed_image
  File.open(File.join(Rails.root, "/app/assets/images/book_default.jpg"))
end

User.create!(name:  "Greate teacher Onizuka",
             username: "GTO",
             gender: "male",
             email: "Onizuka@gmail.com",
             password:              "admin12345",
             password_confirmation: "admin12345",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Greate teacher Onizuka",
             username: "GTO",
             gender: "male",
             email: "Okazuni@gmail.com",
             password:              "admin12345",
             password_confirmation: "admin12345",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

6.times do |n|
    user = Category.create!(name: Faker::Book.genre)
end

15.times do |n|
    user = User.create!(name:  Faker::LeagueOfLegends.champion,
             username: Faker::Superhero.name,
             gender: "male",
             email: Faker::Name.first_name+n.to_s+"@gmail.com",
             password:              "admin12345",
             password_confirmation: "admin12345",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)
    file.puts user.name + "\n" + user.email + "\n" + user.password + "\n\n\n"

    Book.create!(
        title: Faker::Book.title,
        author: Faker::Book.author,
        image: seed_image,
        isbn: Faker::Number.number(10),
        publisher: Faker::Book.publisher,
        publish_date: "02-02-1992",
        categoryid: Faker::Number.between(1, 6),
        description: Faker::Lorem.paragraph(8)
        )
end

books = Book.all
users = User.limit(5).offset 10

users.each do |user|
  books.each do |book|
    Review.create!(
        title: Faker::Book.title+"  "+Faker::Book.author,
        content: Faker::Lorem.paragraph(20),
        user_id: user.id,
        book_id: book.id
      )

    rate = Rate.create!(
        rater_id: user.id,
        rateable_type: "Book",
        rateable_id: book.id,
        stars: Faker::Number.between(1, 5),
        dimension: "original_score"
    )

    book.update_rate_average(rate.stars, "original_score");
  end
end


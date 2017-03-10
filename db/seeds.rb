# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
images_path = "#{Rails.root}/app/assets/images/"
avatars = [(images_path+"avatar1.jpg"), (images_path+"avatar2.jpg"), (images_path+"avatar3.jpg")]
photos = [(images_path+"photo1.jpg"), (images_path+"photo2.jpg"), (images_path+"photo3.jpg")]

User.create!(name:  "Example User",
             email: "qwe@qwe.com",
             password:              "qweqwe",
             password_confirmation: "qweqwe",
             avatar: File.new(avatars.sample))

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  user = User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               avatar: File.new(avatars.sample))
  5.times do |n|
    Post.create!(description: (user.name + n.to_s + "post"), user: user, image: File.new(photos.sample))
  end
end

users = User.all
user  = users.first
following = users[2..8]
followers = users[3..7]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
Post.all.each do |post|
  10.times do
    user = users.sample
    Comment.create(user: user, post: post, body: (user.name + "comment"))
  end
  5.times do |n|
    n+=1
    user = User.find(n)
    user.likes.create(post: post)
  end
end

# Users.each do |user|
# end

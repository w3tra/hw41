# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
test_user = User.create!(name: "test_user", 
                         email: "qwe@qwe.com", 
                         password: "qweqwe")
                         
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  user = User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
  10.times do |n|
    Post.create!(description: (user.name + n.to_s + "post"), user: user)
  end
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
Post.all.each do |post|
  10.times do
    user = users.sample
    Comment.create!(user: user, post: post, body: (user.name + "comment"))
  end
end
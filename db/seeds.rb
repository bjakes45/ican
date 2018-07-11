# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed_users
  user_id = 0
  10.times do 
    User.create(
      name: "test#{user_id}",
      email: "test#{user_id}@test.com",
      password: '123456',
      password_confirmation: '123456'
    )
    user_id = user_id + 1
  end
end

def seed_councils

    5.times do
      Council.create(
        title: Faker::Lorem.sentences[0], 
        description: Faker::Lorem.sentences[0], 
        user_id: rand(1..9), 
      )
    end

end

def seed_memberships
  users = User.all

    users.each do |user|
        Membership.create(
          user_id: user.id, 
          council_id: rand(1..4),
          active: true
      )
    end

end

def seed_posts
  councils = Council.all

  councils.each do |council|
    5.times do
      Post.create(
        title: Faker::Lorem.sentences[0], 
        content: Faker::Lorem.sentences[0], 
        user_id: rand(1..9), 
        council_id: council.id,
        closed: false,
        motion: false
      )
    end
   end

end

seed_users
seed_councils
seed_memberships
seed_posts
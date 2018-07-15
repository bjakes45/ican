# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed_users
  user_id = 0
  20.times do 
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

    council_id = 0
    15.times do
      Council.create(
        title: "Council#{council_id}", 
        description: Faker::Lorem.sentences[0], 
        user_id: rand(1..9), 
      )
      council_id = council_id + 1
    end

end

def seed_memberships
  users = User.all

    users.each do |user|
        Membership.create(
          user_id: user.id, 
          council_id: rand(1..8),
          active: true
      )
    end

end

def seed_posts
  councils = Council.all

  councils.each do |council|
    members_ids = []
    council.memberships.each do |member|
      members_ids += [member.user.id]
    end
    5.times do
      Post.create(
        title: Faker::Lorem.sentences[0], 
        content: Faker::Lorem.sentences[0], 
        user_id: members_ids.sample, 
        council_id: council.id,
        closed: false,
        motion: false
      )
    end
   end

end

def seed_positions
  councils = Council.all


  councils.each do |council|
    position_id = 0
    members_ids = []
    council.memberships.each do |member|
      members_ids += [member.user.id]
    end
    5.times do
      Position.create(
        title: "Position#{position_id}", 
        description: Faker::Lorem.sentences[0], 
        user_id: members_ids.sample, 
        council_id: council.id,
        active: true,
        appointed: false
      )
      position_id = position_id + 1
    end
  end

end

def seed_pos_votes
  councils = Council.all

  councils.each do |council|
    council.positions.each do |position| 
      members = []
      members_ids = []
      council.memberships.each do |member|
        members += [member.user]
        members_ids += [member.user.id]
      end
      PosVote.create(
          vote_id: members.sample, 
          user_id: members_ids.sample, 
          council_id: council.id,
          position_id: position.id,
          active: true
        )
    end
  end

end

seed_users
seed_councils
seed_memberships
seed_posts
seed_positions
seed_pos_votes
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Seeds for development
#=begin
def seed_users
  user_id = 0
  40.times do 
    User.create(
      name: "test#{user_id}",
      email: "test#{user_id}@test.com",
      password: '123456',
      password_confirmation: '123456'
    )
    user_id = user_id + 1
  end
end

def seed_council_categories

    council_category_id = 0
    6.times do
      CouncilCategory.create(
        title: "CouncilCategory#{council_category_id}", 
        description: Faker::Lorem.sentences[0], 
        user_id: rand(1..40), 
      )
      council_category_id = council_category_id + 1
    end

end

def seed_councils
    council_categories = CouncilCategory.all

    council_id = 0
    council_categories.each do |cat|   
      5.times do
        Council.create(
          title: "Council#{council_id}", 
          description: Faker::Lorem.sentences[0], 
          user_id: rand(1..9), 
          council_category_id: cat.id, 
        )
        council_id = council_id + 1
      end
    end

end

def seed_memberships
  users = User.all
  councils = Council.all
  council_ids = []

  councils.each do |council|
    council_ids += [council.id]
  end

  users.each do |user|
      Membership.create(
        user_id: user.id, 
        council_id: council_ids.sample,
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
    if members_ids.length > 0
      5.times do
        Post.create(
          title: Faker::Lorem.sentences[0], 
          content: Faker::Lorem.sentences[0], 
          user_id: members_ids.sample, 
          council_id: council.id,
          closed: [true, false].sample,
          motion: [true, false].sample
        )
      end
    end
   end

end

def seed_mot_votes
  councils = Council.all

  councils.each do |council|
    council.posts.where(motion:true).each do |post|      
      council.memberships.each do |member|
        MotVote.create(
          vote: ['Approve', 'Reject', 'Delay', 'Abstain' ].sample,
          user_id: member.id, 
          post_id: post.id
        )
      end
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
    if members_ids.length > 0
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

end

def seed_pos_votes
  councils = Council.all

  councils.each do |council|
    council.positions.each do |position| 
      members = []
      members_ids = []
      council.memberships.each do |member|
        members += [member.user]
      end
      
      council.memberships.each do |member|
        PosVote.create(
            vote_id: members.sample, 
            user_id: member.id, 
            position_id: position.id,
            active: true
          )
        end
    end
  end

end

seed_users
seed_council_categories
seed_councils
seed_memberships
seed_posts
seed_mot_votes
seed_positions
seed_pos_votes
#=end

#Seeds for production 
#=begin
#=end

class MembVote < ApplicationRecord

	belongs_to :user
	belongs_to :membership
end

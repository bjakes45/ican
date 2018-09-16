class Membership < ApplicationRecord

	belongs_to :user
	belongs_to :council
	has_many :memb_votes
end

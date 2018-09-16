class Position < ApplicationRecord

	belongs_to :user
	belongs_to :council
	has_many :pos_votes
	has_many :incumbents
	has_many :candidates

end

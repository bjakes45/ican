class PosVote < ActiveRecord::Base

	belongs_to :user
	belongs_to :vote_id, :class_name => "User", :foreign_key => "vote_id"
	belongs_to :position

end

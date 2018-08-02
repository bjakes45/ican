module PosVotesHelper
	def check_if_user_has_active_vote
		return @user_vote_active.empty? 
	end
	def check_if_user_has_voted
		return @user_vote.empty? 
	end
end

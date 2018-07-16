module PosVotesHelper
	def check_if_user_has_voted
		@user_vote.empty? ? 'pos_votes/new/not_yet_voted' : 'pos_votes/new/already_voted'
	end
end

class MembVotesController < ApplicationController
	def create
		@memb_vote = MembVote.new
		@membership = Membership.find(params[:membership_id])

		@memb_vote.vote = memb_vote_params[:vote]
		@memb_vote.membership_id = @membership.id
		@memb_vote.user_id = current_user.id

		@memb_vote.save

		redirect_to council_membership_path(@membership.council, @membership)

	end

	def deactivate
		@memb_vote = MembVote.find(params[:memb_vote_id])

		@memb_vote.update(deactivate: true)
		
		redirect_to council_membership_path(@memb_vote.membership.council, @memb_vote.membership)
	end

	private
	
	def memb_vote_params
	  params.require(:memb_vote).permit(:vote)
	end
end

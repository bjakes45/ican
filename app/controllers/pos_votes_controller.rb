class PosVotesController < ApplicationController
	before_action :authenticate_user!	

	def new

		@council = Council.find(params[:council_id])
		@position = Position.find(params[:position_id])
		@vote = ''
		@members = []
		if params[:vote_id]
			@vote = User.find(params[:vote_id])
			@council.memberships.each do |m|
				if @vote.id == m.user.id
					@members += [m.user] 
				else
					@members += [m.user] 
				end  
			end  
		else
			@council.memberships.each do |m|
				@members += [m.user] 
			end 
		end
		@user_vote_active = @position.pos_votes.where(user_id: current_user.id, active: true, deactivate: false).limit(1)
		@user_vote = @position.pos_votes.where(user_id: current_user.id, active: false, deactivate: false).limit(1)
		@pos_vote = PosVote.new

	end

	def create
		@position = Position.find(params[:position_id])
		if !@position.pos_votes.where(user_id: current_user, deactivate:false).empty?
			redirect_to council_position_path(@pos_vote.position.council.id, @pos_vote.position.id)
		end
		@pos_vote = PosVote.new()
	    @pos_vote.vote_id = User.find(pos_vote_params[:vote_id])
	    @pos_vote.user_id = current_user.id
	    @pos_vote.position_id = @position.id 
		if @pos_vote.save
			redirect_to council_position_path(@pos_vote.position.council.id, @pos_vote.position.id)
		else
			redirect_to new_council_position_pos_vote_path(@pos_vote.position.council.id, @pos_vote.position.id, vote_id: params[:vote_id])
		end

	end

	def deactivate
		@pos_vote = PosVote.find(params[:pos_vote_id])
		@pos_vote.update(deactivate: true)

		redirect_to new_council_position_pos_vote_path(@pos_vote.position.council, @pos_vote.position, vote_id: params[:vote_id])
	end

	def accept
		@pos_vote = PosVote.find(params[:pos_vote_id])
		@pos_vote.update(active: true)

		redirect_to council_membership_path(@pos_vote.position.council, current_user)
	end

	def reject
		@pos_vote = PosVote.find(params[:pos_vote_id])
		@pos_vote.update(active: false)

		redirect_to council_membership_path(@pos_vote.position.council, current_user)
	end

	private

	def pos_vote_params
	  params.require(:pos_vote).permit(:vote_id)
	end

end
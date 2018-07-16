class PosVotesController < ApplicationController

	def new

		@council = Council.find(params[:council_id])
		@position = Position.find(params[:position_id])
		@vote = ''
		@members = []
		if params[:vote_id]
			@vote = User.find(params[:vote_id])
			@council.memberships.each do |m|
				if @vote.id == m.user.id
					@members += [[m.user.name, m.user.id]] 
				else
					@members += [[m.user.name, m.user.id]] 
				end  
			end  
		else
			@council.memberships.each do |m|
				@members += [[m.user.name, m.user.id]] 
			end 
		end
		@user_vote = @position.pos_votes.where(user_id: current_user.id, active: true).limit(1)
		@pos_vote = PosVote.new

	
	end

	def deactivate
		@pos_vote = PosVote.find(params[:pos_vote_id])
		@pos_vote.update(active: false)

		redirect_to new_council_position_pos_vote_path(@pos_vote.position.council, @pos_vote.position)
	end
end
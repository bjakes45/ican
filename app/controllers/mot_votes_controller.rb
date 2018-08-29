class MotVotesController < ApplicationController
	before_action :authenticate_user!	

	def create
		@post = Post.find(params[:post_id]) 
		@mot_vote = MotVote.new
		@mot_vote.vote = mot_vote_params[:vote]
		@mot_vote.post_id = @post.id
		@mot_vote.user_id = current_user.id

		@mot_vote.save

		redirect_to council_post_path(@mot_vote.post.council, @mot_vote.post)
		
	end

	def deactivate
		@mot_vote = MotVote.find(params[:mot_vote_id])

		@mot_vote.update(deactivate: true)
		
		redirect_to council_post_path(@mot_vote.post.council, @mot_vote.post)
	end

	private

	def mot_vote_params
	  params.require(:mot_vote).permit(:vote)
	end

end

class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council, except: :deactivate
	before_action :find_executive, except: :deactivate
	before_action :check_if_member, except: :deactivate

	def show

		@post = Post.find(params[:id])
		@comments = Post.where(parent_post_id: params[:id])
		
		if @post.mot_votes.where(user_id: current_user.id, deactivate: false).empty?
			@mot_vote = MotVote.new
		else
			@mot_vote = @post.mot_votes.where(user_id: current_user.id, deactivate: false).first
		end
		
		@total_members = @council.memberships.where(active: true, deactivate: false).count
		
		@approve = @post.mot_votes.where(vote: 'Approve', deactivate:false)
		@reject = @post.mot_votes.where(vote: 'Reject', deactivate:false)
		@abstain = @post.mot_votes.where(vote: 'Abstain', deactivate:false)
		@delay = @post.mot_votes.where(vote: 'Delay', deactivate:false)

		@total_votes = @approve.count + @reject.count + @abstain.count + @delay.count
		@vote_percent = (@total_votes.to_f / @total_members.to_f)*100
		
		@settings = @council.council_settings.where(deactivate:false).first
		if @settings.blank?
			@quorum = ""
		else
			@quorum = @settings.min_mot_vote
		end
	
	end


	def create
		@post = Post.new(post_params)
		@post.council_id = @council.id
		@post.user_id = current_user.id

		if @post.save
			redirect_to council_path(@council)
		else
			redirect_to new_council_post_path(@council, motion: @post.title)
		end
	end

	def comment
		@post = Post.new(comment_params)
		@post.council_id = @council.id
		@post.user_id = current_user.id

		if @post.save
			redirect_to council_post_path(@council, params[:parent_post_id])
		else
			redirect_to council_post_path(@council, params[:parent_post_id])
		end
	end

	def deactivate
		@post = Post.find(params[:post_id])
		@post.deactivate = true
		@post.deactivate_at = Time.now


		if @post.save
			redirect_to council_path(@council)
		else
			redirect_to council_post_path(@council, @post)
		end
	end
	
	private
		def find_council
			@council = Council.find(params[:council_id])
		end	

		def find_executive
			@executive_position = @council.positions.order('created_at ASC').first
			if !@executive_position.blank?
				@executive_incumbent = @executive_position.incumbents.where(active: true).first		
			else
				@executive_incumbent = ""		
			end
			
		end

		def post_params
		  params.require(:post).permit(:title, :content, :motion, :closed)
		end

		def comment_params
		  params.permit(:title, :content, :motion, :closed, :parent_post_id)
		end

end

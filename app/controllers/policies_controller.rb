class PoliciesController < ApplicationController
	before_action :find_council
	before_action :find_executive, only: :index
	before_action :check_executive, only: [:new]

	def index

	end

	def new

		@policy = Policy.new

		@post = Post.find(params[:post_id])
		@policy.post_id = @post.id
		@policy.user_id = current_user.id

		@policy.save

		redirect_to council_post_path(@council, @post, post_id: @policy.post_id)
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
	def check_executive
		@executive_position = @council.positions.order('created_at ASC').first
		if !@executive_position.blank?
			@executive_incumbent = @executive_position.incumbents.where(active: true).first		
			if @executive_incumbent.user != current_user
				redirect_to council_path(@council) 
			end
		else
				redirect_to council_path(@council) 
		end		
	end
end

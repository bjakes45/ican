class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council	
	before_action :check_if_member

	def show
		 @post = Post.find(params[:id])
	end

	def new
		@council = Council.find(params[:council_id])
		@post = Post.new
	end
	
	private
		def find_council
			@council = Council.find(params[:council_id])
		end	
end

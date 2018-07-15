class CouncilsController < ApplicationController
	before_action :authenticate_user!	
	def index

	end

	def show
		@council = Council.find(params[:id])
		@posts = @council.posts
	end

end

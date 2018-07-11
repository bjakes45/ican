class CouncilsController < ApplicationController
	
	def index

	end

	def show
		@council = Council.find(params[:id])
		@posts = @council.posts
	end

end

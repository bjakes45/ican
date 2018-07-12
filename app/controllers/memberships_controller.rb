class MembershipsController < ApplicationController

	def index
		@council = Council.find(params[:council_id])
	end

end

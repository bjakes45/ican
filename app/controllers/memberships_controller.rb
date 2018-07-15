class MembershipsController < ApplicationController
	before_action :authenticate_user!
	def index
		@council = Council.find(params[:council_id])
	end

end

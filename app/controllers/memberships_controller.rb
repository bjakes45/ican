require 'application_helper.rb'

class MembershipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council	
	before_action :check_if_member

	def index

	end

	private
	def find_council
		@council = Council.find(params[:council_id])
	end	

end

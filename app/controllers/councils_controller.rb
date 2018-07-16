require 'application_helper.rb'

class CouncilsController < ApplicationController
	before_action :authenticate_user!	
	before_action :find_council	
	before_action :check_if_member, except: :show

	def show
		@posts = @council.posts
	end

	private
	def find_council
		@council = Council.find(params[:id])
	end
	 
end

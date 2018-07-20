require 'application_helper.rb'

class MembershipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council, except: [:deactivate]	
	before_action :check_if_member, except: [:new, :create, :deactivate]

	def index

	end

	def new

	end

	def create

		@membership = Membership.new
		@membership.council_id = @council.id
		@membership.user_id = current_user.id
		@membership.active = false
		@membership.deactivate = false
		
		if @membership.save
			redirect_to new_council_membership_path(@council)
		else
			redirect_to new_council_membership_path(@council)
		end	
	end

	def deactivate
		@membership = Membership.find(params[:membership_id])

		redirect_to council_path(@membership.council)
	end

	private
	def find_council
		@council = Council.find(params[:council_id])
	end	

end

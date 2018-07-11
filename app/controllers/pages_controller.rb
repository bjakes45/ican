class PagesController < ApplicationController

	def index
		@councils = Council.limit(5)
	end

	def profile
		@user = current_user
		@memberships = Membership.all
	end
end

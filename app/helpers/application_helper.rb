require 'navigation_helper.rb'

module ApplicationHelper
  	include NavigationHelper
  	include Private::ConversationsHelper
  	include Private::MessagesHelper

	def check_user_membership
		if current_user.memberships.where(council_id: @council.id, deactivate:false).empty?
			return false
		else
			return true
		end
	end


	def check_user_membership_active
		if current_user.memberships.where(council_id: @council.id, active: true, deactivate:false).empty?
			return false
		else
			return true
		end
	end

end
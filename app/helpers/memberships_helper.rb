module MembershipsHelper
	def check_if_membership_requested
		current_user.memberships.where(council_id: @council.id, active: false).empty? ? 'memberships/new/new_membership' : 'memberships/new/membership_requested'
	end
end

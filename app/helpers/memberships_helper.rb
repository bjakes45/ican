module MembershipsHelper
	def check_if_membership_requested
		current_user.memberships.where(council_id: @council.id, active: false, deactivate:false).empty? ? 'memberships/new/new_membership' : 'memberships/new/membership_requested'
	end

	def check_if_member_is_current_user
		current_user == @membership.user
	end

	def pending_members_badge
		if @pending_members.count >= 0
			'memberships/pending_members_badge'
		else
			'pages/blank'
		end
	end

	def	check_for_memb_vote
		@membership.memb_votes.where(user_id: current_user, deactivate: false).empty?
	end
end

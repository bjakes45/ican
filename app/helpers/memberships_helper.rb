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

	def contact_user_partial_path
		current_user.memberships.where(council_id: @council.id, active: true, deactivate:false).empty? ? 'pages/blank' : 'memberships/show/member_page/contact_user'

	end

	def leave_message_partial_path
	  if @message_has_been_sent
	    'memberships/show/member_page/contact_user/already_in_touch'
	  else
	    'memberships/show/member_page/contact_user/message_form'
	  end
	end

end



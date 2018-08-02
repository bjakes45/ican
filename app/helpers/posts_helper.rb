module PostsHelper
	def check_for_mot_vote
		if @post.mot_votes.where(user_id: current_user.id, deactivate: false).empty?
			return false
		else
			return true
		end
	end

	def current_user_is_poster_buttons
		if @post.user_id == current_user.id
			'posts/poster_buttons'		
		else
			'pages/blank'
		end
	end
end

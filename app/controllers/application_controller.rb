class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	private

  	def after_sign_in_path_for(resource)
		check_any_user_memberships ? council_posts_path : root_path
	end
	
	def check_any_user_memberships
		if current_user.memberships.where(active: true).empty?
			return false
		else
			return true
		end  	
	end

	def check_user_membership
		if current_user.memberships.where(council_id: @council.id).empty?
			return false
		else
			return true
		end
	end

	def check_if_member
		if !check_user_membership
			redirect_to council_path(@council)
		end
	end

end

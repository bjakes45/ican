class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  	def after_sign_in_path_for(resource)
		check_user_memberships ? council_posts_path : root_path
	end

	private
	
	def check_user_memberships
		if current_user.memberships.where(active: true).empty?
			return false
		else
			return true
		end  	
	end

end

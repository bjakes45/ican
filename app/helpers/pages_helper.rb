module PagesHelper

	def home_page_sign_in_partial_path
	    user_signed_in? ? 'pages/index/signed_in_home_page' : 'pages/index/non_signed_in_home_page'
  	end

  	def check_if_user_councils_empty
  		
  		active_memberships = @user.memberships.where(active: true)
  		
  		active_memberships.empty? ? 'pages/profile/main_content/empty_councils' : 'pages/profile/main_content/display_councils'	 		
  	
  	end

end

module PagesHelper

	def home_page_sign_in_partial_path
	    user_signed_in? ? 'pages/index/signed_in_home_page' : 'pages/index/non_signed_in_home_page'
  	end

end

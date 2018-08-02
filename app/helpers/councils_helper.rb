module CouncilsHelper
	def check_if_posts_found
		if @posts.length == 0
			'councils/show/main_content/posts_empty'
		else
			'councils/show/main_content/found_posts'
		end
	end

	def update_pagination_partial_path
	  if @councils.next_page
	    'councils/councils_pagination_page/update_pagination'
	  else
	    'councils/councils_pagination_page/remove_pagination'
	  end
	end
end

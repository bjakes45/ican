class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :opened_conversations_windows
  before_action :set_cookies
	
	def states
    	render json: CS.states(params[:country]).to_json
  	end

  	def cities
    	render json: CS.cities(params[:state], params[:country]).to_json
  	end

	private

	def set_cookies
		if user_signed_in?
  			if cookies[:user_id].blank?
  			  	cookies[:user_id]= current_user.id
			end
		else
			if cookies[:user_id].present?
  			  	cookies.delete :user_id
			end
		end
	end

  	def after_sign_in_path_for(resource)
		check_any_user_memberships ? user_council_posts_path : root_path
	end
	
	def check_any_user_memberships
		if current_user.memberships.where(active: true, deactivate: false).empty?
			return false
		else
			return true
		end  	
	end

	def check_user_membership
		if current_user.memberships.where(council_id: @council.id, active:true, deactivate: false).empty?
			return false
		else
			return true
		end
	end

	def check_membership_request
		if current_user.memberships.where(council_id: @council.id, active: false, deactivate:false).empty?
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

	def opened_conversations_windows
	  if user_signed_in?
	    # opened conversations
	    session[:private_conversations] ||= []
	    @private_conversations_windows = Private::Conversation.includes(:recipient, :messages)
	                                      .find(session[:private_conversations])
	  else
	    @private_conversations_windows = []
	  end
	end

end

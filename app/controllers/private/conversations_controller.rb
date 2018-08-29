class Private::ConversationsController < ApplicationController

	def create
	  membership = Membership.find(params[:member_id])
	  recipient_id = membership.user.id
	  @conversation = Private::Conversation.new(sender_id: current_user.id, 
	                                           recipient_id: recipient_id) #, council_id: membership.counicil.id
	  if @conversation.save
	    
	    Private::Message.create(user_id: recipient_id, 
	                            conversation_id: @conversation.id, 
	                            body: params[:message_body])
	    

	    add_to_conversations unless already_added?

	    respond_to do |format|
	      format.js {render partial: 'memberships/show/member_page/contact_user/message_form/success'}
	    end


	  else
	    respond_to do |format|
	      format.js {render partial: 'memberships/show/member_page/contact_user/message_form/fail'}
	    end
	  end
	end

	def close
	  @conversation_id = params[:id].to_i
	  session[:private_conversations] ||= []
	  if session[:private_conversations].include?(@conversation_id)
	  	session[:private_conversations].delete(@conversation_id)
	  end


	  respond_to do |format|
	    format.js
	  end
	end

	private

	def add_to_conversations
	  session[:private_conversations] ||= []
	  session[:private_conversations] += [@conversation.id]
	end

	def already_added?
  		session[:private_conversations].include?(@conversation.id)
	end
end

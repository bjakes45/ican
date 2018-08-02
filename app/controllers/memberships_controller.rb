require 'application_helper.rb'

class MembershipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council, except: [:deactivate]
	before_action :find_pending_members, except: [:deactivate]
	before_action :check_if_member, only: :pending

	def index

	end

	def pending
	
	end

	def show
		@membership = Membership.find(params[:id])
		
		if !@membership.memb_votes.where(user_id: current_user, deactivate: false).empty?
			@memb_vote = @membership.memb_votes.where(user_id: current_user, deactivate: false).first
		else
			@memb_vote = MembVote.new
		end
		if !@membership.active
			@total_members = @council.memberships.where(active: true, deactivate: false).count
			@approve = @membership.memb_votes.where(vote: 'Approve', deactivate:false)
			@reject = @membership.memb_votes.where(vote: 'Reject', deactivate:false)
			@abstain = @membership.memb_votes.where(vote: 'Abstain', deactivate:false)
			@delay = @membership.memb_votes.where(vote: 'Delay', deactivate:false)

			@appr_rate = (@approve.count.to_f / (@total_members.to_f - @abstain.count.to_f))*100

			@settings = @council.council_settings.where(deactivate:false).first
			@memb_approve = "No"
			if !@settings.blank?
				if @appr_rate > @settings.memb_vote_threshold
					@membership.update(active:true)
					redirect_to council_memberships_path(@council)
				end
			end
		end
	end

	def new

	end

	def create

		@membership = Membership.new
		@membership.council_id = @council.id
		@membership.user_id = current_user.id
		@membership.active = false
		@membership.deactivate = false
		
		if @membership.save
			redirect_to new_council_membership_path(@council)
		else
			redirect_to new_council_membership_path(@council)
		end	
	end

	def deactivate
		@membership = Membership.find(params[:membership_id])

		@membership.update(deactivate: true, deactivate_at: Time.now)

		redirect_to council_path(@membership.council)
	end

	private
	def find_council
		@council = Council.find(params[:council_id])
	end	

	def find_pending_members
		@pending_members = @council.memberships.where(active:false, deactivate:false)
	end

end

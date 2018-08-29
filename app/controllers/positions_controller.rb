class PositionsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council
	before_action :find_executive
	before_action :find_position, only: :show
	before_action :check_if_member

	def index
		@incumbents_all_count = Incumbent.all.count
	end

	def show

		@incumbents_all_count = Incumbent.all.count
		@incumbents_check = @position.incumbents.count

		@incumbents_all = Incumbent.where(position_id: @position.id)
		@candidates = @position.candidates.all

		@cand_membs = []
		@non_candidates = []
		@council.memberships.each do |m|
			@cand = false
			@candidates.each do |c|
				if m.user.id == c.user.id
					@cand = true
				end
			end
			if @cand
				@cand_membs += [m]
			else
				@non_candidates += [m]
			end

		end

		
		@c_members, @c_members_data = get_members_by_votes(@cand_membs)
		@members, @members_data = get_members_by_votes(@non_candidates)
		@a_members = @c_members + @members
		@a_members_data = @c_members_data + @members_data

		@a_members = @a_members.sort_by { |a| -a[1] }
		@a_members_data = @a_members_data.sort_by { |a| -a[1] }


		@current_leader= @members[0][0]
		@current_incumbent = @incumbents_all.where(active: true).limit(1).first
		if @current_incumbent.present?
			@incumbent_membership = @council.memberships.where(user_id: @current_incumbent.user.id, active: true, deactivate: false).first
		else
			@incumbent_membership = ""
		end

		@current_elected = @incumbents_all.where(active:false, elected:true)

		check_current_incumbent

	end

	def new
		if current_user != @executive_incumbent.user
			redirect_to council_positions_path(@council)
		end

		@position = Position.new
		
	end
	

	private
	def find_council
		@council = Council.find(params[:council_id])
	end	

	def find_position
		@position = Position.find(params[:id])
	end

	def find_executive
		@executive_position = @council.positions.order('created_at ASC').first
		if !@executive_position.blank?
			@executive_incumbent = @executive_position.incumbents.where(active: true).first		
		else
			@executive_incumbent = ""		
		end
	end
	
	def get_members_by_votes(members)
		@members_list = []
		@members_data = []
		@members = members
		@members.each do |m|
			@votes = PosVote.where(position_id: @position.id, vote_id: m.user, deactivate: false, active: true)
			@voted_members = []
			@votes.each do |v|
				@voted_members += [v.user]
			end
			@pending_votes = PosVote.where(position_id: @position.id, vote_id: m.user, deactivate: false, active: false)
			@pending_vote_members = []
			@pending_votes.each do |pv|
				@pending_vote_members = [pv.user]
			end
			@members_list += [[m, @votes.count, @pending_votes.count]]
			@members_data += [[m.user.name, @votes.count]]
		end
		@members_list = @members_list.sort_by { |a| -a[1] }
		@members_data = @members_data.sort_by { |a| -a[1] }
		return @members_list, @members_data
	end

	def check_current_incumbent

		if @current_incumbent.blank?
			if @a_members.count > 1
				if @a_members[0][1] > @a_members[1][1]
					@incumbent = Incumbent.new(user_id: @a_members[0][0].id, position_id: @position.id, active: true, active_at: Time.now )
					@incumbent.save
					redirect_to council_position_path(@council, @position)
				end
			end
		
		end

		#if @current_leader == @current_incumbent

		@current_elected.each do |e|
			if Time.now - e.elected_at > 30.days
				return true	
			end
		end
		
	end

end

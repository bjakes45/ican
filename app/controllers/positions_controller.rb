class PositionsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_council	
	before_action :check_if_member

	def index

	end

	def show
		@position = Position.find(params[:id])
		@members = get_members_by_votes
	end
	
	private
	def find_council
		@council = Council.find(params[:council_id])
	end	

	def get_members_by_votes
		@members_list = []
		@members = Membership.where(council_id: @council.id, active: :true)
		@members.each do |m|
			@votes = PosVote.where(position_id: @position.id, vote_id: m.user, active: true).count
			@members_list += [[m, @votes]]
		end
		@members_list = @members_list.sort_by { |a| -a[1] }
		return @members_list
	end


end

class CandidatesController < ApplicationController
	before_action :authenticate_user!	

	def create
		@position = Position.find(params[:position_id])

		@candidate = Candidate.new(user_id: current_user.id, position_id: @position.id)

		if @candidate.save
			redirect_to council_position_path(@position.council, @position)
		else
			redirect_to council_position_path(@position.council, @position, error: true)

		end
	end

end

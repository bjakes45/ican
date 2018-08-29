module PositionsHelper
	def incumbent_info
		if @current_incumbent.blank?
			'pages/blank'
		else
			'positions/show/incumbent_info'
		end	
	end

	def candidate_info
		if current_user.candidates.where(position_id: @position.id, deactivate: false).present?
			'positions/show/already_declared'
		else
			'positions/show/candidate_button'
		end
	end

	def declared_elsewhere
		
		other_candidates = current_user.candidates.where(deactivate: false).where.not(position_id: @position.id)
		declared = false
		other_candidates.each do |c|
			if c.position.council.id == @council.id
				declared = true
			end
		end


		if declared
			'positions/show/candidate_button/disabled'
		else
			'positions/show/candidate_button/active'
		end
	end		


end

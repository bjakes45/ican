module PositionsHelper
	def incumbent_info
		if @current_incumbent.blank?
			'pages/blank'
		else
			'positions/show/incumbent_info'
		end
		
	end

end

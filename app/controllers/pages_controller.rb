class PagesController < ApplicationController

	def index
		@councils = Council.limit(5)
	end

	def profile

	end
end

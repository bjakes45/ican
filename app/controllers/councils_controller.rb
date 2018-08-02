require 'application_helper.rb'

class CouncilsController < ApplicationController
	before_action :authenticate_user!	
	before_action :find_council, except: [:new, :create]	
	before_action :find_executive, only: [:show, :settings]	

	def show
		@posts = @council.posts.where(deactivate: false)
	end

	def new
		@council = Council.new
		@council_categories = CouncilCategory.all
		file = 'lib/assets/constitution_boilerplate.txt'
		@text = ""
		File.readlines(file).each do |line|
		      @text = @text + line
		end
	end

	def create
		@council = Council.new()
		@council.title = council_params[:title]
		@council.description = council_params[:description]
		@council.council_category = CouncilCategory.find(council_params[:council_category])
		@council.user_id = current_user.id

		initialize_council

	end

	def settings
	
	if @council.council_settings.count == 0
		@council_settings = CouncilSetting.new
		@council_settings.council_id = @council.id
		@council_settings.user_id = current_user.id
		@council_settings.save

		redirect_to council_settings_path(@council)
	else
		@settings = @council.council_settings.where(deactivate:false).first
	end
		
	end

	private
	def find_council
		@council = Council.find(params[:id])
	end

	def find_executive
		@executive_position = @council.positions.order('created_at ASC').first
		if !@executive_position.blank?
			@executive_incumbent = @executive_position.incumbents.where(active: true).first		
		else
			@executive_incumbent = ""		
		end
		
	end

	def initialize_council
		
		if @council.save
			if params[:join]
				@membership = Membership.new
				@membership.council_id = @council.id
				@membership.user_id = current_user.id
				@membership.active = true
				@membership.deactivate = false
		
			 	@membership.save
			end

			@position = Position.new
			@position.title = "Executive"
			@position.description = "The Executive is responsible for enacting decisions made by the Council"
			@position.active = true
			@position.save

			@post = Post.new
			@post.title = @council.name+" Constitution"
			file = 'lib/assets/constitution_boilerplate.txt'
			@text = ""
			File.readlines(file).each do |line|
		      @text = @text+ line
		    end
			@post.content = @text

			redirect_to root_path
		else
			redirect_to new_council_path
		end
	end

	def council_params
	  params.require(:council).permit(:title, :description, :council_category)
	end
	 
end

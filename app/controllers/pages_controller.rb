class PagesController < ApplicationController
	require 'will_paginate/array'
	before_action :authenticate_user!, except: :index
	def index
		get_councils
		@councils = @councils.paginate(page: params[:page], per_page: 16)
		@categories = CouncilCategory.all
		
	end

	def profile
		@user = current_user
		@memberships = Membership.all
	end

	def user_posts
		@user = current_user
	end
	
	def council_posts
		@user = current_user
		@posts_array = []
		@user.memberships.where(active: true).each do |m|
	 		@posts_array += m.council.posts
		end
		@posts = @posts_array.paginate(page: params[:page], per_page: 12)
	end
	private

	def get_councils
		if !params[:category].blank?
			@category = CouncilCategory.find(params[:category]) 
			if !params[:search].blank?
				@councils_ordered = @category.councils.search(params[:search]).joins(:memberships).where("memberships.active = true").group(:id).order("COUNT(memberships.id) DESC")
				@councils_empty = @category.councils.search(params[:search]).includes(:memberships).where(memberships: { id: nil })
			else
				@councils_ordered = @category.councils.joins(:memberships).where("memberships.active = true").group(:id).order("COUNT(memberships.id) DESC") 
				@councils_empty = @category.councils.search(params[:search]).includes(:memberships).where(memberships: { id: nil })
			end 
		else
			if !params[:search].blank?
				@councils_ordered = Council.search(params[:search]).joins(:memberships).where("memberships.active = true").group(:id).order("COUNT(memberships.id) DESC") 
				@councils_empty = Council.search(params[:search]).includes(:memberships).where(memberships: { id: nil })
			else
				@councils_ordered = Council.joins(:memberships).where("memberships.active = true").group(:id).order("COUNT(memberships.id) DESC")
				@councils_empty = Council.includes(:memberships).where(memberships: { id: nil })
			end
		end
		@councils = @councils_ordered + @councils_empty
	end
end

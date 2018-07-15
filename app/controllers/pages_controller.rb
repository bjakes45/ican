class PagesController < ApplicationController
	require 'will_paginate/array'
	before_action :authenticate_user!, except: :index
	def index
		@councils = get_councils.paginate(page: params[:page], per_page: 16)
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
		Council.joins(:memberships).group(:id).order("COUNT(memberships.id) DESC") + Council.includes(:memberships).where(memberships: { id: nil })
	end
end

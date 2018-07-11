class Council < ActiveRecord::Base

	belongs_to :user
	has_many :memberships
	has_many :posts
	
end

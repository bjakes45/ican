class Council < ApplicationRecord

	belongs_to :user
	belongs_to :council_category
	has_many :council_settings
	has_many :memberships
	has_many :posts
	has_many :positions

	def self.search(search)
    	if search
    		q = "%#{search}%"
  			where("councils.description || councils.title ILIKE ?", q)
		end
	end
	
end

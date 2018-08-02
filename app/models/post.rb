class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :council
  	has_many :policies
  	has_many :mot_votes


end

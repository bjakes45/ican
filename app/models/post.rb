class Post < ApplicationRecord

	belongs_to :user
	belongs_to :council
	belongs_to :parent, :class_name => "Post", :foreign_key => "parent_post_id"

	has_many :child_posts, :class_name => "Post", :foreign_key => "child_post_id"
  	has_many :policies
  	has_many :mot_votes


end

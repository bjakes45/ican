class User < ActiveRecord::Base
  
  has_many :councils
  has_many :posts
  has_many :memberships, dependent: :destroy
  has_many :positions
  has_many :pos_votes
  has_many :vote_id, class_name: "Pos_vote", foreign_key: "vote_id"



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

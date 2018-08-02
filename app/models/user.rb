class User < ActiveRecord::Base
  
  has_many :councils
  has_many :councils_settings
  
  has_many :posts
  has_many :memberships, dependent: :destroy
  has_many :positions
  has_many :incumbents
  has_many :policies
  
  has_many :private_messages, class_name: 'Private::Message'
  has_many  :private_conversations, 
          foreign_key: :sender_id, 
          class_name: 'Private::Conversation'
  
  has_many :memb_votes
  has_many :pos_votes
  has_many :mot_votes
  has_many :vote_id, class_name: "Pos_vote", foreign_key: "vote_id"



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

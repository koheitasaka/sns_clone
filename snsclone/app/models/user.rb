class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 30, message: "Too long Username!" }

  has_many :tweets
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  
  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  has_many :relationships
  has_many :followings, through: :relationships,  source: :follow
  has_many :versus_followings,  class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :versus_followings,  source: :user
  
  def already_followed?(other_user)
    self.relationships.exists?(follow_id: other_user.id)
  end
end

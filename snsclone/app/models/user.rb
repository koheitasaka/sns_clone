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

  enum user_status: { normal: 0, suspended: 1 }
  
  has_many :account_suspensions
  has_many :reported_users, through: :account_suspensions, source: :report
  has_many :versus_account_suspensions, class_name: 'AccountSuspension', foreign_key: 'report_id'
  has_many :reporters, through: :versus_account_suspensions, source: :user

  validates :user_status, presence: true

  def already_reported?(other_user)
    self.account_suspensions.exists?(report_id: other_user.id)
  end
  
end

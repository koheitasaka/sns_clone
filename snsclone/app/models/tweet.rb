class Tweet < ApplicationRecord
	belongs_to :user
	validates :body, presence: true, length: { maximum: 140 }
	
	has_many :replies, :class_name => "Tweet", :foreign_key => "tweet_id", dependent: :destroy
	belongs_to :original, :class_name => "Tweet", :foreign_key => "tweet_id", optional: true
	
	has_many :likes, dependent: :destroy
	has_many :liked_users, through: :likes, source: :user
	
	enum status: { open: 0, only_followers: 1, only_me: 2 }

	mount_uploaders :images, ImageUploader
end


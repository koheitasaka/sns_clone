class Tweet < ApplicationRecord
	belongs_to :user
	has_many :replies, :class_name => "Tweet", :foreign_key => "tweet_id", dependent: :destroy
	belongs_to :original, :class_name => "Tweet", :foreign_key => "tweet_id", optional: true
	has_many :likes, dependent: :destroy
	has_many :liked_users, through: :likes, source: :user
end


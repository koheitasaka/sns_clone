class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :user_find, only: [:show, :edit, :update]
	before_action :current_user_find, only: [:timeline, :like_notification, :reply_notification]
	
	def show
			@tweets = Tweet.where(user_id: @user.id).order(created_at: :desc)
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path
		else
			render "edit"
		end
	end

	def timeline
		@following_ids = @user.followings.ids
		@tweets = Tweet.where(user_id: @following_ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
		# binding.pry
		@private_tweets = @tweets.where(status:"only_me")
		@followings_private_tweets = @private_tweets.where(user_id: @following_ids)
		@displayed_tweets = @tweets.where.not(id: @followings_private_tweets.ids)
	end

	def like_notification
		@tweets = Tweet.where(user_id: @user.id)
		@likes = Like.where(tweet_id: @tweets.ids).order(created_at: :desc)
		@likes_of_notification = @likes.where.not(user_id: @user.id)
	end

	def reply_notification
		@tweets = Tweet.where(tweet_id: @user.tweets.ids).order(created_at: :desc)
		@replies = @tweets.where.not(user_id: @user.id) 
	end
	
	private
		def user_find
			@user = User.find_by(id: params[:id])
		end
		
		def current_user_find
			@user = User.find(current_user.id)
		end

		def user_params
			params.require(:user).permit(:username,:bio)
		end

end

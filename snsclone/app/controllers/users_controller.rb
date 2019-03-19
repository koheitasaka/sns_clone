class UsersController < ApplicationController
	before_action :user_find, only: [:show, :edit, :update]
	before_action :current_user_find, only: [:timeline, :like_notification, :reply_notification]

	def show
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
	end

	def like_notification
		@tweets = Tweet.where(user_id: @user.id)
		@likes = Like.where(tweet_id: @tweets.ids).order(created_at: :desc)
	end

	def reply_notification
		@tweets = Tweet.where(tweet_id: @user.tweets.ids)
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

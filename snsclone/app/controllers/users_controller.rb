class UsersController < ApplicationController
	def show
		@user = User.find_by(id: params[:id])	
	end

	def edit
		@user = User.find_by(id: params[:id])	
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to user_path
	end

	def timeline
		@user = User.find(current_user.id)
		@following_ids = @user.followings.ids
		@tweets = Tweet.where(user_id: @following_ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
	end

	def like_notification
		@user = User.find(current_user.id)
		@tweets = Tweet.where(user_id: @user.id)
		@likes = Like.where(tweet_id: @tweets.ids).order(created_at: :desc) #Likeから、@userのtweetの内、likeされたtweetのidがはいったレコードを取得
	end

	def reply_notification
		@user = User.find(current_user.id)
		@tweets = Tweet.where(tweet_id: @user.tweets.ids)
	end
	
	private
		def user_params
			params.require(:user).permit(:username,:bio)
		end
end

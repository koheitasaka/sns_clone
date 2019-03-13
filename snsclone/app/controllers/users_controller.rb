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
		@user = User.find(params[:id])
		@following_ids = @user.followings.ids
		@tweets = Tweet.where(user_id: @following_ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
	end
	
	private
		def user_params
			params.require(:user).permit(:username,:bio)
		end
end

class InfomationsController < ApplicationController
  def index
  	@user = current_user
  	@informations = Infomation.where(user_id: @user.id).or(Infomation.where(user_id: nil)).order(created_at: :desc)
  	# @tweets = Tweet.where(user_id: @following_ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
  end
end

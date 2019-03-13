class TweetsController < ApplicationController
	
	def index
		@tweets = Tweet.all.order(created_at: :desc)
	end

	def new
		
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = current_user.id 
	    @tweet.save
		redirect_to tweets_path
	end

	def destroy
		@tweet = Tweet.find(params[:id])
		@tweet.destroy
		redirect_to tweets_path
	end

	def show
		@tweet = Tweet.find(params[:id])
	end

	private
	def tweet_params
		params.require(:tweet).permit(:body, :tweet_id, :image, :status)
	end
end

class TweetsController < ApplicationController			
	before_action :tweet_find, only: [:show, :destroy]
	before_action :authenticate_user!, except: [:index]

	def index
		@tweet = Tweet.new
		@tweets = Tweet.all.order(created_at: :desc)
	end

	def new
		@tweet = Tweet.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = current_user.id
		if @tweet.save
			@tweets = Tweet.all.order(created_at: :desc)
			if @tweet.tweet_id 
				@replies = @tweet.original.replies.order(created_at: :desc)
			end
			respond_to do |format|
				format.html
				format.js
			end
		else
		    render "new"
		end
	end

	def destroy
		@tweet.destroy
		redirect_to root_path
	end

	def show
		@new_tweet = Tweet.new
		@replies = @tweet.replies.order(created_at: :desc)
	end

	private
		def tweet_find
			@tweet = Tweet.find(params[:id])
		end
		
		def tweet_params
			params.require(:tweet).permit(:body, :tweet_id, :status, {images: []})
		end
end

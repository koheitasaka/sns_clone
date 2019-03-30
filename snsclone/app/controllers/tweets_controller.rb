class TweetsController < ApplicationController
	before_action :tweet_find, only: [:show, :destroy]
	# before_action :authenticate_user!, except: [:index]

	def index
		@tweets = Tweet.all.order(created_at: :desc)
	end

	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = current_user.id 
		if @tweet.save
	    	redirect_to root_path
	    else
	    	render "new"
	    end
	end

	def destroy
		@tweet.destroy
		redirect_to root_path
	end

	def show
	end

	private
		def tweet_find
			@tweet = Tweet.find(params[:id])
		end
		
		def tweet_params
			params.require(:tweet).permit(:body, :tweet_id, :status, {images: []})
		end
end

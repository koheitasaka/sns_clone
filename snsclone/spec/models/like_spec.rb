require 'rails_helper'

RSpec.describe do
	before do
		@user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	@tweet = @user.tweets.create(body:"body")
	end

	it "is valid with user and tweet" do
		like = @user.likes.create(tweet_id:@tweet.id)
		expect(like).to be_valid
	end

	it "does not allow duplicate set between user and tweet" do
		like = @user.likes.create(tweet_id:@tweet.id)
		other_like = @user.likes.create(tweet_id:@tweet.id)
		expect(other_like).not_to be_valid
	end
end
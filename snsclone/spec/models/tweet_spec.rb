require 'rails_helper'

RSpec.describe do
	before do
		@user = create(:user)
	  	@tweet = create(:tweet)
	end

	describe Tweet do
		it do 
			expect(@tweet).to be_valid
		end
	  context " when user doesn't signed in" do
		  it "needs user" do
		  	tweet = Tweet.create(body:"body")
		  	expect(tweet).not_to be_valid
		  end
	  end

 	  it "returns error message when body is blank" do
	  	tweet = @user.tweets.create(body:nil)
	  	expect(tweet.errors.messages[:body][0]).to eq("can't be blank")  
	  end
	end
end
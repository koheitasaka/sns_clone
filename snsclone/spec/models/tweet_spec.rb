require 'rails_helper'

RSpec.describe do
	describe Tweet do
	  it  do
	  	user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	tweet = user.tweets.create(body:"body")
	  	expect(user.tweets.first.body).to eq "body" 
	  end
	end
end
require 'rails_helper'

RSpec.describe do
	describe User do
	  it "is valid with email,username,and password,user_status " do
	  	user = User.new(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	expect(user).to be_valid
	  end
	  context "when user likes tweet"	
	end
end
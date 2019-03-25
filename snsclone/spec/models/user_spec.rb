require 'rails_helper'

RSpec.describe do
	describe "User" do
	  it "is valid with email,username,and password " do
	  	user = User.new(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password"
	  	)
	  	expect(user).to be_valid
	  end	
	end
end
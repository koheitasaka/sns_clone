require 'rails_helper'

RSpec.describe do
	before do
		@user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
	end

	it "does not allow duplicate set between user and tweet" do
		other_user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
		relationship = @user.relationships.create(follow_id:other_user.id)
		other_relationship = @user.relationships.create(follow_id:other_user.id)
		expect(other_relationship).not_to be_valid
	end
end
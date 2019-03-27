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
	  		email:"test2@test.com",
	  		username:"testuser2",
	  		password:"password",
	  		user_status: "normal"
	  	)
	    suspension = @user.account_suspensions.create(report_id: other_user.id)
		other_suspension = @user.account_suspensions.create(report_id: other_user.id)
		expect(other_suspension).not_to be_valid
	end
end
require 'rails_helper'

RSpec.describe do
	before do 
		@user = create(:user)
	end
	describe User do
	  it "is valid with email,username,and password,user_status " do
	  	expect(@user).to be_valid
	  end

	  it "returns error when email is blank" do
	  	@user.email = nil
	  	expect(@user).not_to be_valid
	  end

	  it "returns error when password is blank" do
	  	@user.password = nil
	  	expect(@user).not_to be_valid
	  end

	  it "returns error when username is blank" do
	  	@user.username = nil
	  	expect(@user).not_to be_valid
	  end


	  it "returns error when email is duplicated" do
	  	@other_user = build(:user)
	    @other_user.email = @user.email
	  	expect(@other_user).not_to be_valid 
	  end

	  it "likes tweet" do
	  	tweet = @user.tweets.create(body:"body")
	  	expect(@user.already_liked?(tweet)).to eq(false)
	  end

	  it "follows user" do
	  	other_user = User.create(
	  		email:"test2@test.com",
	  		username:"testuser2",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	expect(@user.already_followed?(other_user)).to eq(false)
	  end

	  it "reports other user as spam" do
	  	other_user = User.create(
	  		email:"test2@test.com",
	  		username:"testuser2",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	expect(@user.already_reported?(other_user)).to eq(false)
	  end
	end
end
require 'rails_helper'

RSpec.describe do
	before do 
		@user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  	)
	end
	describe User do
	  it "is valid with email,username,and password,user_status " do
	  	expect(@user).to be_valid
	  end

	  it "returns error message when email is blank" do
	  	@user = User.create(
	  		email:nil,
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	expect(@user.errors.messages[:email][0]).to eq("can't be blank")
	  end

	  it "returns error message when password is blank" do
	  	@user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:nil,
	  		user_status: "normal"
	  	)
	  	expect(@user.errors.messages[:password][0]).to eq("can't be blank")
	  end

	  it "returns error message when username is blank" do
	  	@user = User.create(
	  		email:"test@test.com",
	  		username:nil,
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	expect(@user.errors.messages[:username][0]).to eq("can't be blank")
	  end


	  it "returns error message when email is duplicated" do
	  	@user = User.create(
	  		email:"test@test.com",
	  		username:"testuser",
	  		password:"password",
	  		user_status: "normal"
	  	)
	  	expect(@user.errors.messages[:email][0]).to eq("has already been taken")
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
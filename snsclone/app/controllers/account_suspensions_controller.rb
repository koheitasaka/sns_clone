class AccountSuspensionsController < ApplicationController
	before_action :find_user
	before_action :authenticate_user!
	
	def create
		unless current_user == @user
			@suspension = current_user.account_suspensions.create(report_id: @user.id)
			redirect_to user_path(@user)
		end
	end

	def destroy
		@suspension = AccountSuspension.find_by(user_id: current_user.id, report_id: @user.id)
		@suspension.destroy
		redirect_to user_path(@user)
	end

	private 
	def find_user
		@user = User.find(params[:user_id])
	end
end


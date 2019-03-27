class RelationshipsController < ApplicationController
	before_action :find_user
	before_action :authenticate_user!
	
	def create
		unless current_user == @user
			@relationship = current_user.relationships.create(follow_id: @user.id)
			redirect_to user_path(@user)
		end
	end

	def destroy
		@relationship = Relationship.find_by(user_id: current_user.id, follow_id: @user.id)
		@relationship.destroy
		redirect_to user_path(@user)
	end

	private 
	def find_user
		@user = User.find(params[:user_id])
	end
end

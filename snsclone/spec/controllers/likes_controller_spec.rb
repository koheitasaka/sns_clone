require "rails_helper"

RSpec.describe do
	describe LikesController do
		before do
			@user = create(:user)
    		login_user @user
		end
		describe "POST #create" do
			it "リクエストは302 リダイレクトとなること" do
				@tweet = create(:tweet)
		        post :create, params:{tweet_id:@tweet.id, like: attributes_for(:like)}
		        expect(response.status).to eq 302
		    end
		end
	end
end


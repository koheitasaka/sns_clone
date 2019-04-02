require "rails_helper"

RSpec.describe do
	describe UsersController do
		before do
			@user = create(:user)
			login_user @user
		end

		describe "GET #show" do
			context '要求されたユーザーが存在する場合' do
		      before do
		      	@tweets = create_list(:tweet, 2)
				@tweets.each do |tweet|
					tweet.user_id = @user.id
					tweet.save
				end
		        get :show, params:{id:@user.id}
		      end
		      it 'リクエストは200 OKとなること' do
		        expect(response.status).to eq 200
		      end
		      it '@userに要求されたユーザーを割り当てること' do
		        expect(assigns(:user)).to eq @user
		      end
		      it ':showテンプレートを表示すること' do
		        expect(response).to render_template :show
		      end
		      it '@tweetsに要求されたtweetを割り当てること' do
				expect(assigns(:tweets)).to eq @tweets 
		      end
		    end
	    end

	    describe 'Get #edit' do
		    before do
		      @user = create(:user)
		      get 'edit', params:{id:@user.id}
		    end
		    it 'リクエストは200 OKとなること' do
		      expect(response.status).to eq 200
		    end
		    it '@userに要求されたユーザーを割り当てること' do
		      expect(assigns(:user)).to eq @user
		    end
		    it ':editテンプレートを表示すること' do
		      expect(response).to render_template :edit
		    end
		end

		describe 'Patch #update' do
		    context '存在するユーザーの場合' do
		      before do
		        @originalname = @user.username
		      end
		      
		      context '有効なパラメータの場合' do
		        before do
		          patch :update, params:{id:@user.id, user: attributes_for(:user, username:"hoge", bio:"hoge")}
		        end
		        it 'リクエストは302 リダイレクトとなること' do
		          expect(response.status).to eq 302
		        end
		        it 'データベースのユーザーが更新されること' do
		          @user.reload
		          expect(@user.username).to eq 'hoge'
		          expect(@user.bio).to eq "hoge"
		        end
		        it 'users#showにリダイレクトすること' do
		          expect(response).to redirect_to user_path(assigns(:user).id)
		        end
		      end
		      
		      context '無効なパラメータの場合' do
		        before do
		          patch :update, params:{id:@user.id, user: attributes_for(:user, username:nil, bio:nil)}
		        end
		        it 'リクエストは200 OKとなること' do
		          expect(response.status).to eq 200
		        end
		        it 'データベースのユーザーは更新されないこと' do
		          @user.reload
		          expect(@user.username).to eq @originalname
		        end
		        it ':editテンプレートを再表示すること' do
		          expect(response).to render_template :edit
		        end
		      end
		    end
		end

		describe "GET #timeline" do
			before do
				@other_user = create(:user)
				@tweets = create_list(:tweet, 5)
				@tweets.each do |tweet|
					tweet.user_id = @user.id
					tweet.save
				end
				@tweets_of_other_user = create_list(:tweet, 5)
				@tweets_of_other_user.each do |tweet|
					tweet.user_id = @other_user.id
					tweet.save
				end
				@relationship = @user.relationships.create(follow_id:@other_user.id)
				get :timeline, params:{id:@user.id}
			end

			it 'リクエストは200 OKとなること' do
		          expect(response.status).to eq 200
		    end
		    it '@userに要求されたユーザーを割り当てること' do
		        expect(assigns(:user)).to eq @user
		    end
		    it '@following_idsに要求された値を割り当てること' do
		        expect(assigns(:following_ids)).to eq @user.followings.ids
		    end
		    it '@tweetsに要求された値を割り当てること' do
		    	@tweets_of_followings_and_user = Tweet.where(user_id: @user.followings.ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
		    	# @tweets.push(@tweets_of_other_user) 
		    	# @tweets_of_followings_and_user.flatten!
		        expect(assigns(:tweets)).to eq @tweets_of_followings_and_user 
		    end
		    it '@private_tweetsに要求された値を割り当てること' do
		    	@tweets_of_followings_and_user = Tweet.where(user_id: @user.followings.ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
		    	@private_tweets = @tweets_of_followings_and_user.where(status:"only_me")
		        expect(assigns(:private_tweets)).to eq @private_tweets
		    end
		    it '@followings_private_tweetsに要求された値を割り当てること' do
		    	@tweets_of_followings_and_user = Tweet.where(user_id: @user.followings.ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
		    	@private_tweets = @tweets_of_followings_and_user.where(status:"only_me")
		    	@followings_private_tweets = @private_tweets.where(user_id:@user.followings.ids)
		        expect(assigns(:followings_private_tweets)).to eq @followings_private_tweets
		    end
		    it '@displayed_tweetsに要求された値を割り当てること' do
		    	@tweets_of_followings_and_user = Tweet.where(user_id: @user.followings.ids).or(Tweet.where(user_id: @user.id)).order(created_at: :desc)
		    	@private_tweets = @tweets_of_followings_and_user.where(status:"only_me")
		    	@followings_private_tweets = @private_tweets.where(user_id:@user.followings.ids)
		    	@displayed_tweets = @tweets_of_followings_and_user.where.not(id:@followings_private_tweets.ids)
		        expect(assigns(:displayed_tweets)).to eq @displayed_tweets
		    end
		end

		describe "GET #like_notification" do
			before do
				@tweets = Tweet.where(user_id: @user.id)
				get :like_notification, params:{id:@user.id}
			end
			it 'リクエストは200 OKとなること' do
		          expect(response.status).to eq 200
		    end
		    it '@tweetsに要求された値を割り当てること' do
		        expect(assigns(:tweets)).to eq @tweets
		    end
		    it "@likesに要求される値を割り当てること" do
		    	@likes = Like.where(tweet_id: @tweets.ids).order(created_at: :desc)
		    	expect(assigns(:likes)).to eq @likes
		    end
		end
		describe "GET #reply_notification" do
			before do
				get :reply_notification, params:{id:@user.id}
			end
			it 'リクエストは200 OKとなること' do
		          expect(response.status).to eq 200
		    end
		    it '@tweetsに要求された値を割り当てること' do
		        @tweets = Tweet.where(tweet_id: @user.tweets.ids).order(created_at: :desc)
		        expect(assigns(:tweets)).to eq @tweets
		    end
		end
	end
end
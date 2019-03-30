require "rails_helper"

RSpec.describe do
	describe TweetsController do
  # userをcreateし、let内に格納
  		before do
    		@user = create(:user)
    		login_user @user
    	end
		describe "GET #index" do
			before do
				@tweets = create_list(:tweet, 5)
				get :index
			end
			
			it "httpリクエストOK" do
				expect(response.status).to eq 200
			end

			it "@tweetsに値が入っている" do
      			expect(assigns(:tweets)).to eq @tweets 
			end

			it "indexテンプレートを表示する" do
				expect(response).to render_template :index
			end
		end	

		describe "GET #new" do
		    before do
		    	@tweet = build(:tweet)
		    	get :new
		    end
		    
		    it "httpリクエストOK" do
		      expect(response.status).to eq 200
		    end
		    
		    it "@tweetに値が入っている" do
		      expect(assigns(:tweet)).to be_a_new(Tweet)
		    end
		    
		    it "newテンプレートを表示する" do
		      expect(response).to render_template :new
		    end
  		end

  		describe "GET #show" do
		    before do
		    	@tweet = create(:tweet)
		    	get :show, params:{id:@tweet.id}
		    end
		    
		    it "httpリクエストOK" do
		      expect(response.status).to eq 200
		    end
		    
		    it "@tweetに値が入っている" do
		      expect(assigns(:tweet)).to eq @tweet
		    end
		    
		    it "newテンプレートを表示する" do
		      expect(response).to render_template :show
		    end
  		end

	  	describe "POST #create" do
		    context "有効なパラメータの場合" do
		      before do
		        @tweet = attributes_for(:tweet)
		      end
		      it "リクエストは302 リダイレクトとなること" do
		        post :create, params:{tweet: @tweet}
		        expect(response.status).to eq 302
		      end
	    	end
	    end

	    describe 'Delete #destroy' do
		    before do
		      @tweet = create(:tweet)
		    end

		    context '存在するtweetの場合' do
		      it 'リクエストは302 リダイレクトとなること' do
		        delete :destroy, params:{id:@tweet.id}
		        expect(response.status).to eq 302
		      end

		      it 'データベースから要求されたtweetが削除されること' do
		        expect{
		          delete :destroy, params:{id:@tweet.id}
		        }.to change(Tweet,:count).by(-1)
		      end

		      it 'users#timelineにリダイレクトされること'do
		        delete :destroy, params:{id:@tweet.id}
		        expect(response).to redirect_to root_path
		      end
		    end

		    context '要求されたtweetが存在しない場合' do
		      it 'リクエストはRecordNotFoundとなること' do
		        expect{
		          delete :destroy, params:{id:"hoge"}
		        }.to raise_exception(ActiveRecord::RecordNotFound)
		      end
    		end
	 	end

	 	describe "GET #timeline" do
	 		before do
	 		end
	 	end
	end
end
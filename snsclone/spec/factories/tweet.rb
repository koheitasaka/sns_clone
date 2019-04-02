FactoryBot.define do
	factory :tweet do
		association :user 
		sequence(:body) { |n| "test_tweet#{n}"}
		sequence(:status) { ["only_me", "only_followers", "open"].sample }
	end
end
FactoryBot.define do
	factory :tweet do
		association :user 
		sequence(:body) { |n| "test_tweet#{n}"}
	end
end
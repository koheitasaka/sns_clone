FactoryBot.define do
	factory :account_suspension do
		association :user
		association :reported_user, through: :account_suspension, source: :report 
	end
end
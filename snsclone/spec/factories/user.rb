FactoryBot.define do

  factory :user do
  	sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "test#{n}@test.com"}
    sequence(:password) {"password"}
    sequence(:password_confirmation) {"password"}
  end
end
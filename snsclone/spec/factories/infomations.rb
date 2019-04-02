FactoryBot.define do
  factory :infomation do
    user { [nil,2,3].sample }
    message { "MyText" }
  end
end

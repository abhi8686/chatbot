FactoryGirl.define do
  factory :user do
    first_name "First"
    sequence(:email) { |n| "user#{n}@Hibot.com" }
    password "pedro19092"
    password_confirmation "pedro19092"

  end
end

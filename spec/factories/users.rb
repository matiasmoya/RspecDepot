FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com"}
    password "foobar1234"

    trait :admin do
      after(:create) { |user| user.update_attribute :admin, true }
    end
  end
end

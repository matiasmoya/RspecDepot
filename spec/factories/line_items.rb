FactoryGirl.define do
  factory :line_item do
    product
    cart
    order
    quantity 1

    trait :many do
      quantity 3
    end
  end
end
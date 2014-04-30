FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "foobar1234"
    factory :admin do
            after(:create) { |user| user.update_attribute :admin, true }
        end
  end
  factory :admon do
    email "matiasmoya@gmail.com"
    password "asdqwe123"
    admin true
  end
  factory :product do
    sequence :title do |n| 
      "Game of thrones #{n}"
    end
    price 99.99
    description %{Aventuras en una tierra de fantasia medieval}
    image_url 'ruby.jpg'
    factory :invalid_product do
      title 'novalid'
    end
  end
end

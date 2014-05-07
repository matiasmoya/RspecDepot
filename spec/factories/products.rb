FactoryGirl.define do
  factory :product do
    sequence :title do |n| 
      "Game of thrones #{n}"
    end
    price 99.99
    description %{Aventuras en una tierra de fantasia medieval}
    image_url 'ruby.jpg'
  end
end
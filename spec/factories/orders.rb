FactoryGirl.define do
  factory :order do
    name 'Order'
    address 'Order adress 123'
    email 'order@order.com'
    pay_type 'Tarjeta de credito'
  end
end

require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    password "password"
  end

  factory :vendor do
    name "VWR"
    address "10 Address"
    city "City"
    state "MA"
    zipcode "02111"
    telephone "6176176171"
  end

  factory :order do
    vendor
    user
    quantity "1"
    cat_number "ABC123"
    url "http://www.google.com"
    price "100"
    product_name "product"
  end
end

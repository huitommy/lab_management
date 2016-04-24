require 'factory_girl'

FactoryGirl.define do
  factory :activity do
    user nil
    action "MyString"
    trackable nil
    trackable_type "MyString"
  end
  
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
  end

  factory :item do
    order
    quantity '15'
    cat_number 'ABC123'
    url "http://google.com"
    price "10"
    product_name "test"
  end
end

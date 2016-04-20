require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    password "password"
  end

  factory :vendor do
    name "#{Faker::Commerce.product_name}"
    address "#{Faker::Address.street_address}"
    city "#{Faker::Address.city}"
    state "#{Faker::Address.state}"
    zipcode "#{Faker::Number.number(5)}"
    telephone "#{Faker::PhoneNumber.cell_phone}"
  end

  factory :order do
    vendor
    user
    quantity "1"
    cat_number "#{Faker::Number.number(5)}"
    url "#{Faker::Internet.url}"
    price "100"
    product_name "#{Faker::Commerce.product_name}"
  end
end

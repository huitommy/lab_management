10.times do
  Vendor.create(
    name: "#{Faker::Commerce.product_name}",
    address: "#{Faker::Address.street_address}",
    city: "#{Faker::Address.city}",
    state: "#{Faker::Address.state}",
    zipcode: "#{Faker::Address.zip}",
    telephone: "#{Faker::PhoneNumber.cell_phone}"
  )
end

20.times do
  user = FactoryGirl.create(:user)
  vendor = Vendor.all.sample
  Order.create(
    user: user,
    vendor: vendor
  )
end

30.times do
  order = Order.all.sample
  Item.create(
    quantity: Faker::Number.number(1),
    cat_number: Faker::Number.number(5),
    url: Faker::Internet.url,
    price: Faker::Number.number(3),
    product_name: Faker::Commerce.product_name,
    order: order
  )
end

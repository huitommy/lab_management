require 'FactoryGirl'

vendors = [
  'VWR',
  'Sigma Aldrich',
  'Roche Life Sciences',
  'Fisher Scientific',
  'Thermo Fisher',
  'Gibco',
  'GE Life Sciences',
  'Macrogen',
  'Invitrogen'
]
vendors.each do |name|
  FactoryGirl.create(:vendor, name: name)
end

FactoryGirl.create(:user, username: "user1", password: "password", admin: true)
FactoryGirl.create(:user, username: "user2", password: "password")

# 50.times do
#   user = FactoryGirl.create(:user)
#   vendor = Vendor.all.sample
#   Order.create(
#     user: user,
#     vendor: vendor
#   )
# end
#
# 200.times do
#   order = Order.all.sample
#   Item.create(
#     quantity: [1, 3, 5, 7, 9].sample,
#     cat_number: Faker::Number.number(5),
#     url: Faker::Internet.url,
#     price: Faker::Number.number(3),
#     product_name: Faker::Commerce.product_name,
#     order: order
#   )
# end

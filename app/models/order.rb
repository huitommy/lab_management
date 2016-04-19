class Order < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :user

  validates :quantity, presence: true
  validates :cat_number, presence: true
  validates :product_name, presence: true
end

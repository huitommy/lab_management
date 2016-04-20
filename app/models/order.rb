class Order < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :user

  validates :cat_number, presence: true
  validates :vendor_id, presence: true
  validates :user_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :product_name, presence: true
  validates :price, presence: true
end

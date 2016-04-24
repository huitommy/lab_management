class Item < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :order

  validates :order_id, presence: true
  validates :quantity, presence: true
  validates :cat_number, presence: true
  validates :price, presence: true
  validates :product_name, presence: true
end

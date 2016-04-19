class Vendor < ActiveRecord::Base
  has_many :orders
  has_many :users, through: :orders

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true, length: { is: 5 }
  validates :telephone, presence: true
end

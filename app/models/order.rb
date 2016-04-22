class Order < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :vendor_id, presence: true
  validates :user_id, presence: true
end

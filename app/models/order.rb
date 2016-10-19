class Order < ApplicationRecord
  include PublicActivity::Common

  belongs_to :vendor
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :vendor_id, presence: true
  validates :user_id, presence: true

  include PgSearch
  pg_search_scope :order_search, associated_against: {
    items: [:cat_number, :product_name, :order_id],
    vendor: [:name],
    user: [:username]
  }, using: { tsearch: { dictionary: "english" } }

  scope :search, -> (query) { order_search(query) if query.present? }
end

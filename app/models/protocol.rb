class Protocol < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user

  validates :name, presence: true
end

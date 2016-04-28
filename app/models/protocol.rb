class Protocol < ActiveRecord::Base
  include PublicActivity::Common
  mount_uploader :document, DocumentUploader
  belongs_to :user

  validates :name, presence: true
end

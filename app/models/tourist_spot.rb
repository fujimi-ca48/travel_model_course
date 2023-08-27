class TouristSpot < ApplicationRecord
  mount_uploader :spot_image, SpotImageUploader

  has_many :total_spot_items, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :name, presence: true
  validates :address, presence: true
end

class TouristSpot < ApplicationRecord
  mount_uploader :spot_image, SpotImageUploader

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end

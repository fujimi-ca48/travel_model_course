class TouristSpot < ApplicationRecord
    mount_uploader :spot_image, SpotImageUploader
end

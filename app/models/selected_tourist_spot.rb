class SelectedTouristSpot < ApplicationRecord
  belongs_to :user
  belongs_to :tourist_spot
end

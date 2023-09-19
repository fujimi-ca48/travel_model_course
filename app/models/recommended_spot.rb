class RecommendedSpot < ApplicationRecord
  mount_uploader :img, SpotImageUploader
  belongs_to :user
  has_many :total_spot_items, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :user, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validate :address_includes_prefecture

  private

  def address_includes_prefecture
    return if address.include?('都') || address.include?('道') || address.include?('府') || address.include?('県')

    errors.add(:address, 'には都道府県名を含めてください')
  end
end

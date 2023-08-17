class RecommendedSpot < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validate :address_includes_prefecture

  private

  def address_includes_prefecture
    unless address.include?('都') || address.include?('道') || address.include?('府') || address.include?('県')
      errors.add(:address, 'には都道府県名を含めてください')
    end
  end
end

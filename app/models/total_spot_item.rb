class TotalSpotItem < ApplicationRecord
  acts_as_list
  
  belongs_to :user
  belongs_to :recommended_spot, optional: true
  belongs_to :tourist_spot, optional: true
  has_one :model_course

  validates :user, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :transportation, presence: true
  validate :exclusive_associations
  enum transportation: { walking: 0, car: 1, train: 2, airplane: 3 }

  attribute :duration, :integer, default: 1
  attribute :transportation, :integer, default: 1

  private

  def exclusive_associations
    if recommended_spot_id.present? && tourist_spot_id.present?
      errors.add(:base, I18n.t('activerecord.errors.models.total_spot_item.exclusive_associations'))
    elsif recommended_spot_id.blank? && tourist_spot_id.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.total_spot_item.either_spot_required'))
    end
  end
end

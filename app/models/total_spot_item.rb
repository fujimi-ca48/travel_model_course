class TotalSpotItem < ApplicationRecord
  acts_as_list

  belongs_to :user
  belongs_to :recommended_spot, optional: true
  belongs_to :tourist_spot, optional: true
  has_one :model_course

  validates :user, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :transportation, presence: true, numericality: { only_integer: true }
  validate :exclusive_associations

  attribute :duration, :integer, default: 1
  attribute :transportation, :integer, default: 1
  enum transportation: { walking: 0, car: 1, train: 2, airplane: 3 }

  def self.find_existing_item(user, params)
    user.total_spot_items.find_by(
      tourist_spot_id: params[:tourist_spot_id],
      recommended_spot_id: params[:recommended_spot_id]
    )
  end

  def self.handle_duplicate_flash_and_redirect(params, flash, redirect_path)
    if params[:tourist_spot_id]
      spot = TouristSpot.find_by(id: params[:tourist_spot_id])
      name = spot&.name
      flash[:danger] = I18n.t('.duplicate_tourist_spot', tourist_spot_name: name)
    elsif params[:recommended_spot_id]
      spot = RecommendedSpot.find_by(id: params[:recommended_spot_id])
      name = spot&.name
      flash[:danger] = I18n.t('.duplicate_recommended_spot', recommended_spot_name: name)
    end
  end

  private

  def exclusive_associations
    if recommended_spot_id.present? && tourist_spot_id.present?
      errors.add(:base, I18n.t('activerecord.errors.models.total_spot_item.exclusive_associations'))
    elsif recommended_spot_id.blank? && tourist_spot_id.blank?
      errors.add(:base, I18n.t('activerecord.errors.models.total_spot_item.either_spot_required'))
    end
  end
end

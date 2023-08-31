class ModelCourse < ApplicationRecord
  belongs_to :user
  has_many :total_spot_items, class_name: 'TotalSpotItem'

  validates :user, presence: true
  validates :name, presence: true
  validates :all_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :spot_item_data, presence: true
  validate :at_least_one_recommended_spot
  enum vehicle: { walking: 0, car: 1, train: 2, airplane: 3 }

  attr_accessor :selected_recommended_spot_id
  attr_accessor :selected_tourist_spot_id
  attr_accessor :selected_duration
  attr_accessor :selected_transportation
  attr_accessor :position
  
  def spot_item_data_array
    JSON.parse(spot_item_data).map(&:with_indifferent_access)
  end

  def at_least_one_recommended_spot
    spot_items = JSON.parse(spot_item_data)
    has_recommended_spot = spot_items.any? { |item| item['recommended_spot_id'].present? }

    unless has_recommended_spot
      errors.add(:spot_item_data, "should have at least one item with recommended_spot_id")
    end
  end
end

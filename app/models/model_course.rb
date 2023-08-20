class ModelCourse < ApplicationRecord

  belongs_to :user
  has_many :total_spot_items, class_name: 'TotalSpotItem'
  serialize :total_spot_item_data, Array

  validates :user_id, presence: true
  validates :name, presence: true
  validates :all_time, presence: true, numericality: { greater_than: 0 }
  validates :duration, numericality: { greater_than: 0, allow_nil: true }

  enum transportation: { walking: 0, car: 1, train: 2, airplane: 3 }

  attribute :duration, :integer, default: 1
  attribute :transportation, :integer, default: 0

  attr_accessor :selected_recommended_spot_id
  attr_accessor :selected_tourist_spot_id
  attr_accessor :selected_duration
  attr_accessor :selected_transportation

  def spot_item_data_array
    JSON.parse(spot_item_data).map(&:with_indifferent_access)
  end
end

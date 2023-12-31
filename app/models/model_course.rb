class ModelCourse < ApplicationRecord
  belongs_to :user
  has_many :total_spot_items, class_name: 'TotalSpotItem'
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_model_courses, through: :bookmarks, source: :model_course
  has_many :likes, dependent: :destroy
  has_many :like_model_courses, through: :likes, source: :model_course

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

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def like_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  def spot_item_data_array
    JSON.parse(spot_item_data).map(&:with_indifferent_access)
  end

  def at_least_one_recommended_spot
    spot_items = JSON.parse(spot_item_data)
    has_recommended_spot = spot_items.any? { |item| item['recommended_spot_id'].present? }

    unless has_recommended_spot
      errors.add(:spot_item_data, "1つ以上My穴場スポットをリストに含めてください")
    end
  end

  def self.prefectures
    select(:prefecture)
      .where.not(prefecture: nil)
      .pluck(:prefecture)
      .uniq
  end

  def self.ransackable_attributes(auth_object = nil)
    ["prefecture", "vehicle"]
  end


  def self.create_with_spot_items(user, model_course_params, total_spot_items)
    spot_item_data = total_spot_items.map do |item|
      {
        recommended_spot_id: item.recommended_spot_id,
        tourist_spot_id: item.tourist_spot_id,
        duration: item.duration,
        transportation: item.transportation,
        position: item.position
      }
    end

    model_course = user.model_courses.build(model_course_params)
    model_course.spot_item_data = spot_item_data.to_json

    transportations = total_spot_items.map(&:transportation)

    most_common_transportation = transportations.max_by { |transportation| transportations.count(transportation) }
    
    model_course.vehicle = TotalSpotItem.transportations[most_common_transportation]

    address_counts = total_spot_items.map do |item|
      address = item.recommended_spot&.address || item.tourist_spot&.address
      address&.match(/([北東名][都道府県]|.{2,3}[都道府県])/)&.captures&.first
    end
    address_counts.compact!
    most_common_prefecture = address_counts.max_by { |address| address_counts.count(address) }
    model_course.prefecture = most_common_prefecture if most_common_prefecture

    if model_course.save
      total_spot_items.each(&:destroy)
    end

    model_course
  end
end

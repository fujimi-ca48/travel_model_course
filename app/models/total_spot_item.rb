class TotalSpotItem < ApplicationRecord
  acts_as_list
  
  belongs_to :user
  belongs_to :recommended_spot, optional: true
  belongs_to :tourist_spot, optional: true
  has_one :model_course

  validates :user_id, presence: true

  enum transportation: { walking: 0, car: 1, train: 2, airplane: 3 }

  attribute :duration, :integer, default: 1
  attribute :transportation, :integer, default: 1
end

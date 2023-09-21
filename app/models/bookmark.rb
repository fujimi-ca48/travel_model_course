class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :model_course

  validates :user_id, uniqueness: { scope: :model_course_id }
end

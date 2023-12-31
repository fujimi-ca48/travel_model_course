class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  authenticates_with_sorcery!
  has_many :recommended_spots, dependent: :destroy
  has_many :model_courses, dependent: :destroy
  has_many :total_spot_items, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_model_courses, through: :bookmarks, source: :model_course
  has_many :likes, dependent: :destroy 
  has_many :like_model_courses, through: :likes, source: :model_course

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  enum role: { general: 0, admin: 1 }

  def total_spot_items_checkout
    total_spot_items.map do |item|
      {
        total_spot_item_id: total_spot_item.id,  # total_spot_item_id の値を設定
        recommended_spot_id: item.recommended_spot_id,
        tourist_spot_id: item.tourist_spot_id,
        duration: item.duration,
        transportation: item.transportation
      }
    end
  end

  def total_spot_items_count
    total_spot_items.count
  end
end

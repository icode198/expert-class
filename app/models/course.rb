class Course < ApplicationRecord
  validates :title, presence: true, length: { maximum: 48 }
  validates :description, presence: true, length: { maximum: 1200, too_long: 'Too long. Maximum is 1200 characters.' }
  validates :instructor, presence: true, length: { maximum: 48 }
  validates :duration, presence: true, length: { maximum: 12 }
  validates :image, {
    presence: true
  }

  has_many :reservations, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  def image_url
    url_for(image)
  end
end

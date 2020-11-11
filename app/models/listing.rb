class Listing < ApplicationRecord
  belongs_to :seller_profile
  has_one_attached :image
  validates :title, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :quantity, presence: true
  validates :price, presence: true
end

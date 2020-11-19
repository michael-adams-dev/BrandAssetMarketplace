class SellerProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :listings, dependent: :destroy
  has_one_attached :brand_logo

  has_many :reviews, as: :reviewable, dependent: :destroy

  validates :brand_name, presence: true, length: { maximum: 80 }
  validates :brand_description, presence: true, length: { in: 10..500 }
  validates :contact_email, presence: true
end

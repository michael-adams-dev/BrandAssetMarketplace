class SellerProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :listings
  has_one_attached :brand_logo

  has_many :reviews, as: :reviewable
end

class Listing < ApplicationRecord
  belongs_to :seller_profile
  has_one_attached :image
end

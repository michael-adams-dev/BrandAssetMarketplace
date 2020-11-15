class Listing < ApplicationRecord
  belongs_to :seller_profile

  belongs_to :category

  has_one_attached :image

  has_many :reviews, as: :reviewable
  
  validates :title, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :quantity, presence: true
  validates :price, presence: true

  scope :search_by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }
  scope :search_by_category, ->(category_ids) { joins(:category).merge(Category.where(id: category_ids)) }
end

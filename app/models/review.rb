class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true

  validates :comment, presence: true, length: { in: 5..500 } 
end

class Category < ApplicationRecord
  has_many :listings
  # enum name: { catering: 0, signage: 1, clothing: 2, electrical: 3, marquees: 4, 
  #   furniture: 5, installations: 6, miscellaneous: 7 }
end

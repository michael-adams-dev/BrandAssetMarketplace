class AddSellerProfileRefToListings < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :seller_profile, null: false, foreign_key: true
  end
end

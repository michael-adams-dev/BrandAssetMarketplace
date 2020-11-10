class AddUserRefToSellerProfiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :seller_profiles, :user, foreign_key: true
  end
end

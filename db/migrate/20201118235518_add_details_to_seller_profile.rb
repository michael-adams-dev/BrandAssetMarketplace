class AddDetailsToSellerProfile < ActiveRecord::Migration[6.0]
  def change
    change_column_null :seller_profiles, :brand_name, false
    change_column_null :seller_profiles, :brand_description, false
    change_column_null :seller_profiles, :contact_email, false
  end
end

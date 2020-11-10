class CreateSellerProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_profiles do |t|
      t.string :brand_name
      t.text :brand_description
      t.string :brand_url
      t.string :contact_number
      t.string :contact_email

      t.timestamps
    end
  end
end

class AddPriceToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :price, :decimal, precision: 7, scale: 2
  end
end

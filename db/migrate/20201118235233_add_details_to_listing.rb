class AddDetailsToListing < ActiveRecord::Migration[6.0]
  def change
    change_column_null :listings, :title, false
    change_column_null :listings, :description, false
    change_column_null :listings, :quantity, false
  end
end

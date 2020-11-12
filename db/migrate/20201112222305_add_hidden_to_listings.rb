class AddHiddenToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :hidden, :boolean, default: false
  end
end

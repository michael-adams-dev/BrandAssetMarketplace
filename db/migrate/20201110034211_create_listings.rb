class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.integer :quantity
      t.timestamps
    end
  end
end

class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :percent
      t.integer :num_of_items
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end

class CreateInssDiscountTables < ActiveRecord::Migration[7.0]
  def change
    create_table :inss_discount_tables do |t|
      t.float :min_range, null: false
      t.float :max_range, null: false
      t.float :discount_percentage, null: false
      t.timestamps
    end
  end
end

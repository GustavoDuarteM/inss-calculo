class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :id_document, null: false
      t.float :salary, null: false
      t.float :inss_discount, null: false
      t.string :discount_status, null: false

      t.timestamps
    end
  end
end

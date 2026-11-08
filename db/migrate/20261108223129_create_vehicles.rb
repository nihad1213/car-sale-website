class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.string :title
      t.string :make
      t.string :car_model
      t.integer :year
      t.decimal :price
      t.integer :mileage
      t.string :fuel
      t.string :transmission
      t.references :body_type, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.string :badge
      t.text :description
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end

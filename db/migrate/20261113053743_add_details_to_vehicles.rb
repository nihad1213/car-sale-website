class AddDetailsToVehicles < ActiveRecord::Migration[8.0]
  def change
    add_column :vehicles, :model, :string

    add_index :vehicles, :make
    add_index :vehicles, :year
    add_index :vehicles, :price
  end
end

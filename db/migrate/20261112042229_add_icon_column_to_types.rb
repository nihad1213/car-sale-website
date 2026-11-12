class AddIconColumnToTypes < ActiveRecord::Migration[8.1]
  def change
    add_column :body_types, :icon, :string
  end
end

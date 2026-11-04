class CreatePermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :permissions do |t|
      t.string :name
      t.bigint :created_by
      t.bigint :updated_by
      t.timestamps
    end
  end
end

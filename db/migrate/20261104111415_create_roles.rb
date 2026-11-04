class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.references :permission, foreign_key: true
      t.bigint :created_by
      t.bigint :updated_by
      t.timestamps
    end
  end
end

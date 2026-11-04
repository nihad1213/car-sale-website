class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.references :role, foreign_key: true
      t.bigint :created_by
      t.bigint :updated_by
      t.timestamps
    end
  end
end

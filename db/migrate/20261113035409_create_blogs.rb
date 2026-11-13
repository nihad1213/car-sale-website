class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs do |t|
      t.string :header, null: false
      t.bigint :created_by
      t.bigint :updated_by
      t.timestamps
    end

    add_index :blogs, :created_by
    add_index :blogs, :updated_by
    add_foreign_key :blogs, :users, column: :created_by
    add_foreign_key :blogs, :users, column: :updated_by
  end
end

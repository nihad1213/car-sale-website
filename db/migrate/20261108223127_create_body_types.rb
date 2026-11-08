class CreateBodyTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :body_types do |t|
      t.string :name
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end

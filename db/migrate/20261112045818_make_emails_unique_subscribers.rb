class MakeEmailsUniqueSubscribers < ActiveRecord::Migration[8.1]
  def change
    add_index :subscribers, :email, unique: true
  end
end

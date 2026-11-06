class RemovePermissionIdFromRoles < ActiveRecord::Migration[8.1]
  def change
    remove_reference :roles, :permission, foreign_key: true if column_exists?(:roles, :permission_id)
  end
end

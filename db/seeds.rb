# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Starting database seeding..."

# 1. Define and Create Permissions
permission_names = [
  "view_dashboard",
  "create_user",
  "updated_user",
  "delete_user"
]

permissions = permission_names.map do |perm_name|
  Permission.find_or_create_by!(name: perm_name)
end
puts "Created/Verified #{permissions.count} permissions: #{permission_names.join(', ')}"

# 2. Create Roles
admin_role = Role.find_or_create_by!(name: "Admin")
regular_role = Role.find_or_create_by!(name: "User")
puts "Created/Verified roles: Admin, User"

# 3. Assign ALL permissions to the Admin role
permissions.each do |permission|
  unless admin_role.permissions.include?(permission)
    admin_role.permissions << permission
  end
end
puts "Assigned all permissions to the Admin role."

# 4. Create System Admin User
admin_user = User.find_or_create_by!(email: "admin@carwebsite.com") do |user|
  user.first_name = "System"
  user.last_name = "Admin"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = admin_role
end
puts "Admin user ready: #{admin_user.email} (Password: password123)"

# 5. Create a Regular Test User
regular_user = User.find_or_create_by!(email: "user@carwebsite.com") do |user|
  user.first_name = "John"
  user.last_name = "Doe"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = regular_role
end
puts "Regular user ready: #{regular_user.email} (Password: password123)"

puts "Seeding finished successfully!"

module ApplicationHelper
  def show_admin_bar?
    current_user.present? && current_user.admin? && !controller_path.start_with?("admin/")
  end
end

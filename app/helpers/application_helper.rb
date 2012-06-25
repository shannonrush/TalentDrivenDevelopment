module ApplicationHelper
  def dashboard_path_for_user
    send("#{current_user.class.name.underscore}_dashboard_path",current_user)
  end
end

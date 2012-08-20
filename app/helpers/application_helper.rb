module ApplicationHelper
  
  def dashboard_path_for_user
    send("#{current_user.class.name.underscore}_dashboard_path",current_user)
  end
  
  def image_name(name)
    name.delete(" ").underscore+".png"
  end

end

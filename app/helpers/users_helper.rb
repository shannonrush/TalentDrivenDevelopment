module UsersHelper
  def path_for_user(user)
    send("#{user.class.name.underscore}_path",user)  
  end  
end

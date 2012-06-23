class ConfirmationsController < Devise::ConfirmationsController 
  
  protected 

   # The path used after confirmation. 
  def after_confirmation_path_for(resource_name, resource) 
    send("edit_#{resource.class.name.underscore}_path",resource)
  end 
end
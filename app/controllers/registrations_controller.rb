class RegistrationsController < Devise::RegistrationsController
  def new
    @type = params[:type]
    super
  end

  def create
    super
  end

  def update
    super
  end
  
  
  protected
  
  def resource_class
    @type = params.delete(:type)
    @type.capitalize.constantize
  end
end
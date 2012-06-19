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
    if ['agent','talent'].include?(params[:type])
      @type = params.delete(:type)
      @type.capitalize.constantize
    else
      super
    end
  end
end
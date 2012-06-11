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
end
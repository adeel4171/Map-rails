class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to template_index_path, :alert => exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:title,:role_ids])
  end

  def after_sign_in_path_for(resource)
  
  	tracks_path
  end

  # def after_sign_up_path_for(resource)
  # 	puts '*****************SignUP ******************'
  # 	puts resource.inspect
  # 	redirect_to people_path
  # end

end

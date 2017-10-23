class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]


   def new
     @invitation_code = params[:code]
     super
   end

   def create
     @invitation_code = params[:code]
     super
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

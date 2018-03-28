class Users::SessionsController < Devise::SessionsController

  #before_action :authenticate_admin!
  #skip_before_action :authenticate_user!, raise: false
 #   before_action :configure_sign_in_params, only: [:create]
 # before_action :current_user_present?, only:[:new]
 
  # GET /resource/sign_in
  # def new
  #    super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # def after_sign_in_path_for(users)
  #   root_path
  # end

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

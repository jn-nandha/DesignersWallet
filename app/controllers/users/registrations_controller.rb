class Users::RegistrationsController < Devise::RegistrationsController
 before_action :configure_sign_up_params, only: [:create]
 before_action :configure_account_update_params, only: [:update]
 before_action :authenticate_admin!
#  before_action :authenticate_user!
   $cty = City.all.pluck(:city_name)

  #GET /resource/sign_up
    # def new
    #   super
    # end

  # POST /resource
  # def create
  #    super
  # end

  # GET /resource/edit
  def edit
     # @ct = City.find(resource.city_id).city_name
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  
  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
  # binding.pry
  ctnm = params[:user][:city_id]
  ct = City.select(:id).where(city_name: ctnm.upcase) 
  params[:user][:city_id] = ct[0].id
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city_id, :activation])
end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    ctnm = params[:user][:city_id]
    ct = City.select(:id).where(city_name: ctnm.upcase) 
    params[:user][:city_id] = ct[0].id
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:city_id, :activation])
  end

    # def after_update_path_for(resource)
    #   user_path(resource)
    # end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
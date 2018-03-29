class Users::RegistrationsController < Devise::RegistrationsController
 before_action :configure_sign_up_params, only: [:create]
 before_action :configure_account_update_params, only: [:update]
 

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
      @resource = User.find(params[:id])
  end

  # PUT /resource
  # def update
  #   super
  # end
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
# <<<<<<< HEAD
  ctnm = params[:user][:city_id]
  ct = City.select(:id).where(city_name: ctnm.upcase) 
  params[:user][:city_id] = ct[0].id
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city_id, :activation])
# end
# =======
    # ctnm = params[:user][:city_id]
    # ct = City.select(:id).where(city_name: ctnm.upcase) 
    # params[:user][:city_id] = ct[0].id
    # name = params[:user][:name]
    # params[:user][:name] = name.capitalize
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city_id, :activation])
  end


  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    ctnm = params[:user][:city_id]
    ct = City.select(:id).where(city_name: ctnm.upcase) 
    params[:user][:city_id] = ct[0].id
    name = params[:user][:name]
    params[:user][:name] = name.capitalize
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:city_id, :activation])
  end


  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def authenticate_user!(opts={})
    
    opts[:scope] = :user
    if params[:action] == 'edit' && params[:controller] == 'users/registrations'
      true
    else
      warden.authenticate!(opts) # if !devise_controller? || opts.delete(:force)
    end
  end
end

class Admins::ManageController < ApplicationController
  before_action :authenticate_admin! # here authenticate admin before action
  skip_before_action :authenticate_user! # here skip authenticate user in all methods

  def index
   @users = User.all.paginate(:page => params[:page], :per_page => 5)
   #@designs =Design.find(params[:id]).paginate(:page => params[:page], :per_page => 3)
  end
#--> search the User By name 
  def search
   if params[:search].blank?
      @users = []
   else
      @users = User.where("name LIKE ?","#{params[:search]}%")
      respond_to do |format|
      format.js
      format.html
    end
  end
  end

#--> Shows the index page with side navigation
  def manage_user
     @uid = params[:id]
          @users = User.all.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
            respond_to do |format|
              format.html # index.html.erb
              format.json { render json: @users }
              format.js
            end
  end
#--> Shows the user profile with his designs
  def profile
       @users = User.find(params[:id])
       #.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
  end
#--> edit the user
  def edit
       @user = User.find(params[:id])      
  end
#--> update the user details
  def update
    if admin_logged_in?
      @user = User.find(params[:id])
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      if @user.update_attributes(params[:user])
        flash[:notice] = "Successfully updated User."
        redirect_to manage_path
      else
        render :action => 'edit'
      end
    end
  end
#--> delete the user
  def delete_user
         @user = User.find(params[:id])
      if @user.destroy
        flash[:notice] = "Successfully deleted User."
        redirect_to manage_user_path
      end
  end
#--> show all design in the index page
  def show_all_design
    @designs = Design.all.paginate(:page => params[:page], :per_page => 4)
  end
#--> update the users activation status
  def update_activation
    @uid = params[:id]
       @status = User.find(params[:id])
    if @status.activation == true
       @status.activation = false
    else
       @status.activation =  true
    end
    @status.save!
  
  end
#--> shows the all block / unblock list of users
  def activate_user
    @users = User.all.paginate(:page => params[:page], :per_page => 4).order("created_at DESC")
  end
  
  private
  
  def user_params
    params[:user].permit(:email, :password, :search,:name, :city_id ,:page, :activation)
  end
end
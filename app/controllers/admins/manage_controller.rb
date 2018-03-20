class Admins::ManageController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!

  def index
   @users = User.all.paginate(:page => params[:page], :per_page => 5)
   # @designs =Design.find(params[:id]).paginate(:page => params[:page], :per_page => 3)
  end

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

  def manage_user
          @users = User.all.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
            respond_to do |format|
              format.html # index.html.erb
              format.json { render json: @users }
              format.js
            end
  end

  def create
    @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "Successfully created User." 
        redirect_to root_path
      else
        render :action => 'new'
      end
  end

  def profile
       @users = User.find(params[:id])
       #.paginate(:page => params[:page], :per_page => 4).order('created_at DESC')
  end

  def edit
    if admin_logged_in?
      @user = User.find(params[:id])      
    end
  end

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

  def delete_user
    if admin_logged_in?
      @user = User.find(params[:id])
      if @user.destroy
        flash[:notice] = "Successfully deleted User."
        redirect_to manage_user_path
      end
    end
  end

  def show_all_design
    @designs = Design.all.paginate(:page => params[:page], :per_page => 4)
  end
  
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

  def activate_user
    @users = User.all.paginate(:page => params[:page], :per_page => 4).order("created_at DESC")
  end
  
  private
  
  def user_params
    params[:user].permit(:email, :password, :search,:name, :city_id ,:page, :activation)
  end
end
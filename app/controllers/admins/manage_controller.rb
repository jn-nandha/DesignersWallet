class Admins::ManageController < ApplicationController
  # before_action -> (user = current_admin) { require_permission user }, only: [:create,:edit, :destroy] 
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!


  def index
    @users = User.all
    @designs =Design.all
  end

  def search
   @users = User.where(["name LIKE ?","%#{params[:search]}%"])
  #where("name LIKE ? OR ingredients LIKE ? OR cooking_instructions LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
  end


  def manage_user
      @user = User.all.paginate(:page => params[:page], :per_page => 3)
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
    @user = User.find(params[:id])
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
    @designs = Design.all
  end

  def update_activation
    binding.pry
    # @status = User.find(params[:job_id])
    # if @status.activation == true
    #   @status.activation = false
    # else
    #   @status.activation =  true
    # end
    @status.save!
    flash[:notice] = "User Status Changed Successfully...."
  end

  def activate_user
    @users = User.all
  end
  
  private
  
  def user_params
    params[:user].permit(:email, :password, :name, :city_id ,:page, :activation)
  end
end
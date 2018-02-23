class ManageController < ApplicationController
	before_action :authenticate_admin!
	
	  #load_and_authorize_resource

  def index
    @users = User.all
    @design =Design.all

  end

  def manage_user
    @user = User.new
    @user = User.all
    respond_to do |format|
			format.js
			format.html
end
  end

  def profile
		@user = User.joins(:city, :designs)
		@design =Design.all
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

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated User."
      redirect_to manage_user_path
    else
      render :action => 'edit'
    end
  end

  def delete_user
    @user = User.find_by(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to manage_user_path
    end
  end 

  def render_show_design
    redirect_to :controller => 'designs', :action => 'show', :id => 1
   
  end

  def user_params
    params[:user].permit(:email, :password, :name, :city_id , :activation)
  end
end
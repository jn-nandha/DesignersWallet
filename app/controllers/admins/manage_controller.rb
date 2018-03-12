class Admins::ManageController < ApplicationController
   before_action -> (user = current_admin) { require_permission user }, only: [:create,:edit, :destroy] 
   before_action :authenticate_admin!

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
     warden.authenticate!(:scope => :admin)
    #binding.pry
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
      @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to manage_user_path
    end
  end 

  def show_all_design
    @design = Design.all
  end

  def activate_user
    if @user.activation === true
          flash[:notice] = 'User is Unblocked'
        else
          flash[:notice] = 'User is Blocked'
      redirect_to manage_user_path
    end 
  end
 
  private

  # def find_user_by_id
  #   @user = User.find(params[:id])
  # end  

  # def received_filter
  #   params[:filter]
  # end

  def user_params
    params[:user].permit(:email, :password, :name, :city_id , :activation)
  end

end
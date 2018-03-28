class Admins::ManageController < ApplicationController
  before_action :authenticate_admin! # here authenticate admin before action
  #skip_before_action :authenticate_user! # here skip authenticate user in all methods

  def index
      @users = User.all.paginate(:page => params[:page], :per_page => 5)
  end
#--> search the User By name ,email,city
  def search
    if params[:search].blank?
       @users = []
    else
       @users=User.joins(:city).where("name LIKE ? OR email LIKE ? OR city_name LIKE ? ","#{params[:search]}%","#{params[:search]}%","#{params[:search].upcase}%").paginate(:page => params[:page], :per_page => 9)
       respond_to do |format|
       format.js
       format.html
       end
    end
  end

#--> Shows the index page with side navigation
  def manage_user
      @users = User.all.paginate(:page => params[:page], :per_page => 9).order('created_at DESC')
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

#--> delete the user
  def delete_user
      @deleteid= params[:id]
         @user = User.find(params[:id])
      if @user.destroy
        flash[:notice] = "Successfully deleted User."
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
      @users = User.all.paginate(:page => params[:page], :per_page => 9).order("created_at DESC")
  end
  
  private
  
  def user_params
    params[:user].permit(:email, :password, :search,:name, :city_id ,:page, :activation)
  end
end
# this class defines methods for design module.
class DesignsController < ApplicationController
  def index
    @designs = Design.all if current_user.activation
  end

  def new
    @design = Design.new
    @cat = Category.all
  end

  def create
    return unless current_user.activation
    if params[:categories].nil?
      flash[:danger] = 'Please select category.if you dont want to put your image in any category you can select Other from given options.'
      redirect_to new_design_path
    else
      if design_params[:description].present? && design_params[:image].present?
        @design = Design.new(design_params)
        @design.user_id = current_user.id
        if @design.save!
          selected_categories = params[:categories].split(',')
          @design.categories << Category.where(cat_name: selected_categories)
          flash[:success] = 'design is uploaded.'
          redirect_to user_profile_path(id: current_user.id)
        else
          flash[:danger] = 'Something went wrong.please try again later'
          redirect_to new_design_path
        end
      else
        flash[:danger] = 'please choose image and give description'
        redirect_to new_design_path
      end
    end
  end

  def del_design
    @did = params[:design_id]
    des = Design.find(params[:design_id])
    usr = des.user if des.user == current_user
    des.destroy if usr.activation
  end

  private

  def design_params
    params.require(:design).permit(:image, :description)
  end
end

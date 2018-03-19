# this class defines methods for design module.
class DesignsController < ApplicationController
  def index
    if current_user.activation
      @designs = Design.all
    end
  end

  def new
    @design = Design.new
    @cat = Category.all
  end

  def create
    if current_user.activation
      if params[:categories] == nil
        flash[:danger] = 'Please select category.if you dont want to put your image in any category you can select Other from given options.'
        redirect_to new_design_path
      else
        if design_params[:description] != "" && design_params[:image]
          @design = Design.new(design_params)
          @design.user_id = current_user.id
          if @design.save!
            @design.categories << Category.where(id: params[:categories]) 
            flash[:success] = 'design is uploaded.'
            redirect_to show_path
          else
            flash[:danger] = 'Something went wrong.please try again after sometime'
            redirect_to new_design_path
          end
        else
          flash[:danger] = 'please choose image and give description'
          redirect_to new_design_path
        end
      end
    end
  end

  def del_design
    @did = params[:design_id]
    des = Design.find(params[:design_id])
    if(des.user == current_user)
      usr = des.user
      des.destroy if usr.activation
    end
  end

  private

  def design_params
    params.require(:design).permit(:image, :description)
  end
end

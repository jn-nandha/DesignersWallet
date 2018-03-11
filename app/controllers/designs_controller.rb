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
				p "Please select category.if you dont want to put your image in any category you can select Other from given options."
			else
				if design_params[:description] != "" && design_params[:image]
					@design = Design.new(design_params)
					@design.user_id = current_user.id
					if @design.save!
						@design.categories << Category.where(id: params[:categories]) 
						redirect_to designs_show_uploaded_design_path, notice: "design is uploaded"
					else
						p "rejected."
					end
				else
					p "please choose image and give description"
				end
			end
		end
	end


	def show_uploaded_design
		if current_user.activation
			@designs = Design.where(user_id: current_user.id)
		end
	end

	def del_design
		@did = params[:design_id]
		des = Design.find(params[:design_id])
		if des.user == current_user
			usr = des.user
			if usr.activation
				des.destroy
				
			end
		end
		
	end

	private
	def design_params
		params.require(:design).permit(:image , :description )
	end
end

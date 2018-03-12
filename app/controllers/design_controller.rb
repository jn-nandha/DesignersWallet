class DesignController < ApplicationController

	def index
  	end

	def new
		@design = Design.new
	end

	def create
		@design = Design.new(design_params)
		@design.user_id = 1
		if @design.save!
			redirect_to design_show_path, notice: "design is uploaded"
		else
			p "rejected."
		end
	end




	def show
		@designs = Design.all
	end

	private
	def design_params
		params.require(:design).permit(:description, :image)
	end
end

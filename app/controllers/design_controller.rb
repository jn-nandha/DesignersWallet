class DesignController < ApplicationController
	before_action :authenticate_user!

	def new
		@design = Design.new
	end

	def create
		@design = Design.new(design_params)
		@design.user_id = current_user.id
		if @design.save!
			redirect_to design_show_path, notice: "design is uploaded"
		else
			p "rejected."
		end
	end

	def show
		@designs = Design.where(user_id: current_user.id)
	end

	private
	def design_params
		params.require(:design).permit(:description, :image)
	end
end

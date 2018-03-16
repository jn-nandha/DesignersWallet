class HomeController < ApplicationController
	before_action :authenticate_user!

	
	def error
	end
	def index
end
	def dashboard
		@cat = Category.all
	
		if current_user.activation
			design_selection = params[:design_selection]
			if design_selection == nil
				design_selection = "Following's Designs"
			end
			if design_selection == "Following's Designs"

				a= FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "accepted",block: false).map(&:to_id)
				@followings = User.where(id: a, activation: true)
				@designs = Design.joins(:user).where(user_id: @followings).order("updated_at DESC") 
			elsif design_selection == "All Designs"
					@designs = Design.all.order("updated_at DESC")
			end
		else
				redirect_to home_error_path
		end
		
	end
	

	def image_info
		if current_user.activation
			@design = Design.find(params[:design_id])
		end
	end

	def search
		if params[:categories] == nil
		else
				@designs = Design.includes(:categories).where(categories: {id: params[:categories] })
		end
	
	respond_to do |format|
	   	format.js
	   	format.html
   	end
  	end	
 
end

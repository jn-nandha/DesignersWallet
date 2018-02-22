class FavouriteController < ApplicationController


	def add_to_fav
		@fav = Favourite.new
		@fav.user_id = current_user.id
		@fav.design_id = params[:design_id]
		@fav.save!
		redirect_to home_dashboard_path
	end

	def del_from_fav
		favourite = Favourite.find_by(user_id: current_user.id, design_id: params[:design_id])
		favourite.delete
		redirect_to home_dashboard_path
	end
end

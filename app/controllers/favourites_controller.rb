class FavouritesController < ApplicationController

	def change_fav
		@did = params[:design_id]
		if current_user.activation
			a= Favourite.where(user_id: current_user.id, design_id: params[:design_id])
			if a[0].nil?
				fav = Favourite.new
				fav.user_id = current_user.id
				fav.design_id = params[:design_id]
				fav.save!
			else
				favourite = Favourite.find(a[0].id)
				favourite.destroy
			end
		end
	end

	def fav_images
		@designs = fav_designs
	end

	private
	def fav_designs
		d = Favourite.where(user_id: current_user.id).pluck(:design_id)
		return Design.where(id: d)
	end

end

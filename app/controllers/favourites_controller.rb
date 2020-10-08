class FavouritesController < ApplicationController
  def change_fav
    @did = params[:design_id]
    if current_user.activation
      favourite = current_user.favourited(@did)
      if favourite
        favourite.destroy
      else
        fav = Favourite.create!(user_id: current_user.id, design_id: params[:design_id] )
      end
    end
  end

  def fav_images
    @designs = current_user.favourited_designs
  end
end

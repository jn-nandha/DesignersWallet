class HomeController < ApplicationController
	def dashboard
		a= FollowingList.joins(:to).where(from_id: current_user.id,follow: "A",block: false).map(&:to_id)
		@followings = User.where(id: a, activation: true)
		@designs = Design.joins(:user).where(user_id: @followings).order("updated_at DESC") 
	end

	def image_info
		if current_user.activation
			@design = Design.find(params[:design_id])
		end
	end

	# def search
	# 	if params[:search] != ""
	# 		users = User.where('name LIKE ?', "%#{params[:search]}%")
	# 	end
	# end




	def search
	if params[:search] == nil
	elsif params[:search][:user] == ""
			p "please enter name of user"
		else
			txt = params[:search][:user]
			@users = User.where('name LIKE ?',txt.capitalize + '%')
	end
	
	respond_to do |format|
   		format.js
   		format.html
   	end
  end	
end

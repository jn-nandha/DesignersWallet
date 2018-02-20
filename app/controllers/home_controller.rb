class HomeController < ApplicationController
	def dashboard
		a= FollowingList.joins(:to).where(from_id: current_user.id,follow: "A",block: false).map(&:to_id)
		@followings = User.where(id: a, activation: true)
		@designs = Design.joins(:user).where(user_id: @followings)    #.order("updated_at DESC")    
	end
end

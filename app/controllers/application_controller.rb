class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
 	before_action :authenticate_user!, :requestcount
	def requestcount
		@reqcount = FollowingList.joins(:to).where(to_id: current_user.id , follow_status: "requested" , block: false).count
	end
end

class ProfileController < ApplicationController
	def show
		#count the numbers of followers
		@followerscount = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "accepted",block: false).map(&:to_id)
		@totalfollowing = @followerscount.count
		#count the numbers of followings
		@followingscount = FollowingList.joins(:to).where(to_id: current_user.id,follow_status: "accepted",block: false).map(&:to_id)
		@totalfollower = @followingscount.count
	end
end

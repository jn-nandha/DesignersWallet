class ProfileController < ApplicationController
	def show
		#count the numbers of followers
		@followerscount = FollowingList.joins(:to).where(from_id: current_user.id,follow: "A",block: false).map(&:to_id)
		# @following = User.where(id: @followingscount, activation: true)
		@totalfollowing = @followerscount.count
		#count the numbers of followings
		@followingscount = FollowingList.joins(:to).where(to_id: current_user.id,follow: "A",block: false).map(&:to_id)
		# @follower = User.where(id: @followerscount, activation: true)
		@totalfollower = @followingscount.count
	end
end

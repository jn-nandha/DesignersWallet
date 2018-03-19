class ProfileController < ApplicationController
		#count the numbers of followers
	def show 
		@followerscount = FollowingList.joins(:to).where(to_id: current_user.id,follow_status: "accepted",block: false).map(&:to_id)
		@totalfollower = @followerscount.count 
	#count the numbers of followings
		@followingscount = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "accepted",block: false).map(&:to_id)
		@totalfollowing = @followingscount.count 
	end
	def user_profile
	  @user = User.find(params[:id])
	  @user_followercount = FollowingList.accepted.where(to_id: @user).count
	  @user_followingcount = FollowingList.accepted.where(from_id: @user).count 
	end

end


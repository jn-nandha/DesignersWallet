class ProfileController < ApplicationController
	#shows the user profile
	def show 
		@followerscount = FollowingList.joins(:to).where(to_id: current_user.id,follow_status: "accepted").map(&:to_id)
		@totalfollower = @followerscount.count 
	#count the numbers of followings
		@followingscount = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "accepted").map(&:to_id)
		@totalfollowing = @followingscount.count
	#blocked user 
		@blockedusers = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "blocked")
	#current user uploaded design	
		@designs = Design.where(user_id: current_user.id)

	end
	#other user profile
	def user_profile
	  @user = User.find(params[:id])
	  @user_followercount = FollowingList.accepted.where(to_id: @user).count
	  @user_followingcount = FollowingList.accepted.where(from_id: @user).count 
	end
	
end


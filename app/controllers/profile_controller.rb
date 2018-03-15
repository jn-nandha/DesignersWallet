class ProfileController < ApplicationController
  #shows the user profile
  def show 
    @followerscount = FollowingList.joins(:to).where(to_id: current_user.id,follow_status: "accepted").map(&:to_id)
    @totalfollower = @followerscount.count 
  #count the numbers of followings
    @followingscount = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "accepted").map(&:to_id)
    @totalfollowing = @followingscount.count
  
  #current user uploaded design 
    @designs = Design.where(user_id: current_user.id)
    @user = current_user
  end
  #other user profile
  def user_profile
    @user = User.find(params[:id])
    @designs = @user.designs
    @user_followercount = FollowingList.accepted.where(to_id: @user).count
    @user_followingcount = FollowingList.accepted.where(from_id: @user).count 
  end
  
  def blockeduser
    #blocked user 
    a = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "blocked").map(&:to_id)
    @blockedusers = User.where(id: a, activation: true)
  end
end


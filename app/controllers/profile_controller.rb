class ProfileController < ApplicationController
  # show user profile
  def user_profile
    @user = User.find(params[:id])
    @designs = @user.designs
    @user_follower_count = FollowingList.accepted.where(to_id: @user).count
    @user_following_count = FollowingList.accepted.where(from_id: @user).count
  end
  # blocked user list
  def blockeduser_list
    @blockedusers = current_user.blocked_by_me
  end
end

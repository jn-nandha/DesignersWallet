class ProfileController < ApplicationController
  # shows the user profile
  def show
    @total_follower = FollowingList.joins(:to).accepted.where(to_id: current_user.id).map(&:from_id).count
    # count the numbers of followings
    @total_following = FollowingList.joins(:to).accepted.where(from_id: current_user.id).map(&:to_id).count
    # current user uploaded design
    @designs = Design.where(user_id: current_user.id)
    @user = current_user
  end

  # other user profile
  def user_profile
    @user = User.find(params[:id])
    @designs = @user.designs
    @user_followercount = FollowingList.accepted.where(to_id: @user).count
    @user_followingcount = FollowingList.accepted.where(from_id: @user).count
  end

  def blockeduser
    # blocked user
    a = FollowingList.joins(:to).where(from_id: current_user.id, follow_status: 'blocked').map(&:to_id)
    @blockedusers = User.where(id: a, activation: true)
  end
end

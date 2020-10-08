class ProfileController < ApplicationController
  # show user profile
  def user_profile
    @user = User.find(params[:id])
    if !current_user.invalid_users.include?(@user)
      @designs = @user.designs
      @user_follower_count = @user.followers.count
      @user_following_count = @user.followings.count
    else
      redirect_to root_path
    end
  end

  # blocked user list
  def blockeduser_list
    @blockedusers = current_user.blocked_by_me
  end
end

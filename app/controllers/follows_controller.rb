class FollowsController < ApplicationController
  
  after_action :index, only: [:blockuser,:follow_req,:approved,:cancel_request,:revert_request]
  # show all the User name except you
  def index
    fetch_records
  end

  # from sending request to other block_to_me
  def follow_req
    @request_to_id = params[:to_id]
    if current_user.requested_by me?
      render html: 'you already requested'
    else
      followinglist = FollowingList.create!(from_id: current_user.id, to_id: params[:to_id], follow_status: 'requested')
    end
  end

  # approved the request
  def approved
    @id = params[:from_id]
    accept = FollowingList.requested.where('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    accept[0].accepted!
  end

  # cancel the request
  def cancel_request
    @id = params[:from_id]
    cancel_req = FollowingList.find_by('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    FollowingList.delete(cancel_req.id)
  end

  # Revert the request
  def revert_request
    @id = params[:to_id]
    cancel_req = FollowingList.delete_follow(current_user.id,params[:to_id])
  end

  # block the block_to_me
  def blockuser
    @userid = params[:to_id]
    block = FollowingList.new(from_id: current_user.id, to_id: params[:to_id], follow_status: 'blocked')
    block.save!
  end

  # unblock the user
  def unblockuser
    any_user = FollowingList.where(to_id: current_user.id, from_id: params[:id])
    .or(FollowingList.where(to_id: params[:id], from_id: current_user.id))
    FollowingList.delete(any_user) if any_user.present?
    @userid = params[:id]
  end

  # followers details
  def followers_list
    @follower = current_user.followers.paginate(page: params[:page], per_page: 7)
  end

  # followings details
  def followings_list
    @following = current_user.followings
  end

  def search
    fetch_records
    if params[:name].blank?
      @users = []
    else
      @users = User.where('name LIKE ? and id != ?', "#{params[:name].capitalize}%", current_user.id)
    end
  end

  private
  def fetch_records
    @allusers =  current_user.search_users("")
    @requested = current_user.requested_users
    @accepted = current_user.followings
    @users = @allusers - @requested
  end
end


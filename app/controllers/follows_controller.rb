class FollowsController < ApplicationController
  
  after_action :index, only: [:blockuser,:follow_req,:approved,:delete_request,:unfollow]
  # show all the User name except you
  def index
    fetch_records
  end

  # from sending request to other block_to_me
  def follow_req
    @request_to_id = params[:to_id]
    @checkcount = FollowingList.where(to_id: params[:to_id], from_id: current_user.id, follow_status: 'requested')
    if @checkcount.empty?
      followinglist = FollowingList.new(from_id: current_user.id, to_id: params[:to_id], follow_status: 'requested')
      followinglist.save!
    else
      render html: 'you already requested'
    end
    fetch_records
  end

  # approved the request
  def approved
    @id = params[:from_id]
    accept = FollowingList.requested.where('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    accept[0].accepted!
    fetch_records
  end

  # cancel the request
  def delete_request
    @id = params[:from_id]
    cancel_req = FollowingList.find_by('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    FollowingList.destroy(cancel_req.id)
    fetch_records
  end

  # unfollow the block_to_me
  def unfollow
    unfollow_req = FollowingList.find_by('to_id = ? and from_id = ?', params[:to_id], current_user.id)
    FollowingList.destroy(unfollow_req.id)
    redirect_to follows_path
    fetch_records
  end

  # block the block_to_me
  def blockuser
    @userid = params[:to_id]
    block = FollowingList.new(from_id: current_user.id, to_id: params[:to_id], follow_status: 'blocked')
    block.save!
    fetch_records
  end

  # unblock the user
  def unblockuser
    any_user = FollowingList.where(to_id: current_user.id, from_id: params[:id])
                            .or(FollowingList.where(to_id: params[:id], from_id: current_user.id))
    FollowingList.delete(any_user) if any_user.present?
  end

  # followers details
  def followers_list
    @follower = current_user.followers.paginate(page: params[:page], per_page: 7)
  end

  # followings details
  def followings_list
    @following = current_user.followings.paginate(page: params[:page], per_page: 7)
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

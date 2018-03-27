class FollowsController < ApplicationController
  
  after_action :index, only: [:blockuser,:follow_req,:approved,:delete_request,:unfollow]
  
  def index
    fetch_records
  end

  def follow_req
    @request_to_id = params[:to_id]
    if current_user.requested_by_me?
      flash[:success] = 'you already requested'
    else
      followinglist = FollowingList.create!(from_id: current_user.id, to_id: params[:to_id], follow_status: 'requested')
    end
    fetch_records
  end

  def approved
    @id = params[:from_id]
    accept = FollowingList.requested.where('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    accept[0].accepted!
    fetch_records
  end

  def cancel_request
    @id = params[:from_id]
    cancel_req = FollowingList.find_by('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    FollowingList.delete(cancel_req.id)
    fetch_records
  end

  def revert_request
    @id = params[:to_id]
    cancel_req = FollowingList.find_by('from_id = ? and to_id = ?', current_user.id, params[:to_id])
    FollowingList.delete(cancel_req.id)
    fetch_records
  end

  def unfollow
    unfollow_req = FollowingList.find_by('to_id = ? and from_id = ?', params[:to_id], current_user.id)
    FollowingList.delete(unfollow_req.id)
    fetch_records
  end

  def blockuser
    @userid = params[:to_id]
    block = FollowingList.create!(from_id: current_user.id, to_id: params[:to_id], follow_status: 'blocked')
    fetch_records
  end

  def unblockuser
    any_user = FollowingList.where(to_id: current_user.id, from_id: params[:id])
    .or(FollowingList.where(to_id: params[:id], from_id: current_user.id))
    FollowingList.delete(any_user) if any_user.present?
    @userid = params[:id]
  end

  def followers_list
    @follower = current_user.followers.paginate(page: params[:page], per_page: 7)
  end

  def followings_list
    @following = current_user.followings.paginate(page: params[:page], per_page: 7)
  end

  def search
    fetch_records
    @users =  if params[:name].blank? 
                  []
              else
                User.where('name LIKE ? and id != ?', "#{params[:name].capitalize}%", current_user.id)
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
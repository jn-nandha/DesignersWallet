class FollowsController < ApplicationController
  # show all the User name except you
  def index
    allusers = User.where('id != ? and activation = ?', current_user.id, true)
                   .pluck(:id)
    @requested = FollowingList.requested.paginate(page: params[:page], per_page: 7)
                              .where('from_id = ?', current_user.id).pluck(:to_id)
    @accepted = FollowingList.accepted.paginate(page: params[:page], per_page: 7)
                             .where('from_id = ?', current_user.id).pluck(:to_id)
    blocked = FollowingList.blocked.where('from_id = ? or to_id = ?',current_user.id,current_user.id)
    from = blocked.pluck(:from_id).uniq
    to = blocked.pluck(:to_id).uniq
    blockeduser = from + to + [current_user.id]
    @searchuser = User.where(id: (allusers - blockeduser))
    @users = User.paginate(page: params[:page], per_page: 7).where(id: (allusers - blockeduser))
  end

  # from sending request to other block_to_me
  def follow_req
    @checkcount = FollowingList.where(to_id: params[:to_id], from_id: current_user.id)
    if @checkcount.empty?
      followinglist = FollowingList.new
      followinglist.from_id = current_user.id
      followinglist.to_id = params[:to_id]
      followinglist.follow_status = 'requested'
      redirect_to follows_path if followinglist.save!
    else
      render html: 'you already requested'
    end
  end

  # respond
  def respond_to_req
    @follows = FollowingList.joins(:to).paginate(page: params[:page], per_page: 7)
                            .where(to_id: current_user.id, follow_status: 'requested')
  end

  # approved the request
  def approved
    accept = FollowingList.requested.where('to_id = ? and from_id = ?',current_user.id,params[:from_id])
    accept[0].accepted!
    redirect_to follows_path
  end

  # cancel the request
  def delete_request
    cancelreq = FollowingList.find_by('to_id = ? and from_id = ?', current_user.id, params[:from_id])
    FollowingList.destroy(cancelreq.id)
    redirect_to follows_path
  end

  # unfollow the block_to_me
  def unfollow
    unfollowreq = FollowingList.find_by('to_id = ? and from_id = ?', params[:to_id], current_user.id)
    FollowingList.destroy(unfollowreq.id)
    redirect_to follows_path
  end

  # block the block_to_me
  def blockusers
    block_by_me = FollowingList.where(to_id: params[:id],from_id: current_user.id)
    block_to_me = FollowingList.where(to_id: current_user.id,from_id: params[:id])
    if FollowingList.exists?(block_by_me)
      block_by_me[0].blocked!
    else
      followinglist = FollowingList.new
      followinglist.from_id = current_user.id
      followinglist.to_id = params[:id]
      followinglist.follow_status = 'blocked'
      followinglist.save!
    end
    if FollowingList.exists?(block_to_me)
      block_to_me[0].blocked!
    else
      followinglist = FollowingList.new
      followinglist.from_id = params[:id]
      followinglist.to_id = current_user.id
      followinglist.follow_status = 'blocked'
      followinglist.save!
    end
  end

  # unblock the block_to_me
  def unblockuser
    @userid = params[:id]
    @unblock = FollowingList
               .where(to_id: params[:id], from_id: current_user.id).blocked
    @unblock.destroy_all
  end

  # followers details
  def followers
    followers_count = FollowingList.joins(:to)
                                   .where(to_id: current_user.id, follow_status: 'accepted')
                                   .map(&:from_id)
    @follower = User.paginate(page: params[:page], per_page: 7)
                    .where(id: followers_count, activation: true)
  end

  # followings details
  def followings
    followings_count = FollowingList.joins(:to)
                                    .where(from_id: current_user.id, follow_status: 'accepted')
                                    .map(&:to_id)
    @following = User.paginate(page: params[:page], per_page: 7)
                     .where(id: followings_count, activation: true)
  end

  def search
    index
    if params[:name].blank?
      @users = []
    else
      @users = User.where('name LIKE ? and id != ?',
                          "#{params[:name].capitalize}%", current_user.id)
    end
  end
end

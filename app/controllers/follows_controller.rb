class FollowsController < ApplicationController
	#show all the User name except you
	def index 
		@users = User.where('id != ? and activation = ?',current_user.id , true)
		@requested = FollowingList.requested.where('block = ? and from_id = ?',false,current_user.id).map(&:to)
		@accepted = FollowingList.accepted.where('block = ? and from_id = ?',false,current_user.id).map(&:to)
	end

	#from sending request to other user
	def follow_req	
		@checkcount = FollowingList.where(to_id: params[:to_id], from_id: current_user.id )
		if @checkcount.length == 0			
			@followinglist = FollowingList.new
			@followinglist.from_id = current_user.id
			@followinglist.to_id = params[:to_id]
			@followinglist.follow_status = "requested"
			@followinglist.block = false
			if @followinglist.save!
				redirect_to follow_path
			end
		else
			render html: 'you already requested'
		end
	end

	#respond 
	def respond_to_req
		@follows = FollowingList.joins(:to).where(to_id: current_user.id , follow_status: "requested" , block: false)
	end

	#approved the request
	def approved
		@accept = FollowingList.requested.where("to_id = ? and from_id = ? and block = ?",current_user.id,params[:from_id],false)
		@accept[0].accepted!
		redirect_to follow_path 
	end
	#cancel the request
	def delete_request
		@cancelreq = FollowingList.find_by("to_id = ? and from_id = ?",current_user.id, params[:from_id])
		FollowingList.destroy(@cancelreq.id)
		redirect_to follow_path
	end
	#unfollow the user
	def unfollow
		@unfollowreq = FollowingList.find_by("to_id = ? and from_id = ?",params[:to_id],current_user.id)
		FollowingList.destroy(@unfollowreq.id)
		redirect_to follow_path  
	end
	#block the user
	def blockusers
		@bluser = FollowingList.where(to_id: current_user.id , from_id: params[:id]).or(FollowingList.where(to_id: params[:id] , from_id: current_user.id)).update(block: "true")
	end
	#followers details
	def followers
		followerscount = FollowingList.joins(:to).where(to_id: current_user.id,follow_status: "accepted",block: false).map(&:from_id)
		@follower = User.where(id: followerscount, activation: true)
		binding.pry
	end
	#followings details
	def followings
		followingscount = FollowingList.joins(:to).where(from_id: current_user.id,follow_status: "accepted",block: false).map(&:to_id)
		@following = User.where(id: followingscount, activation: true)
	end

	def search
		index
		if params[:name].blank?
			@users = []
		else
			@users = User.where("name LIKE ? and id != ?","#{params[:name].capitalize}%",current_user.id)
		end
	
	end
  
end

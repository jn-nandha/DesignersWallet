class FollowController < ApplicationController

	def index
		@users = User.select(:name,:id).where('id != ?', current_user)
	end

	def req	
		@followinglist = FollowingList.new
		@followinglist.from_id = current_user.id
		@followinglist.to_id = params[:to_id]
		@followinglist.follow = "R"
		@followinglist.block = false
		if @followinglist.save!
			redirect_to follow_path
		end
	end

	def respond_to_req
		@follows = FollowingList.joins(:user).where(to_id: current_user.id , follow: "R" , block: false)
	end

	def approved
		@accept = FollowingList.select(:id,:follow,:block,:from_id).where("to_id = ? and follow = ? and from_id = ?",current_user.id ,"R",params[:from_id])
		if @accept[0].block === false
			@accept = FollowingList.where("to_id = ? and follow = ? and from_id = ?",current_user.id,"R",params[:from_id]).update(:follow => "A")  
		end
	end

	def delete_request
		@accept = FollowingList.select(:id,:block).where("to_id = ? and from_id = ?",current_user.id,params[:from_id])
		if @accept[0].block === false
			@accept = FollowingList.
	end
end

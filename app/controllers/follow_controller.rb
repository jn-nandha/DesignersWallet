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
		binding.pry
		if @followinglist.save!
			redirect_to follow_path
		else
			p "rejected."
		end
	end

	def respond_to_req
		@follows = FollowingList.joins(:user).where(to_id: current_user.id , follow: "R" , block: false)
	end

	def acc_req
		@u = FollowingList.where(from_id:)
	end

	def del_req
	end
end

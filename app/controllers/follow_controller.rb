class FollowController < ApplicationController
	def index
		@user = User.select(:name).where('id != ?', 1)
		@cunt = @user.count
	end
	def request
		@followinglist = FollowingList.new(followinglist_params)
		@followinglist.sender_id = 1
		if @followinglist.save!
			redirect_to follow_show_path, notice: "design is uploaded"
		else
			p "rejected."
		end
	end
	private
	def following_params
		params.require(:followinglist).permit(:follow, :block, :to_id, :from_id)
	end
end
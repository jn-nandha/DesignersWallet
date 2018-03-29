class FollowsController < ApplicationController
	def index
		@requested = current_user.requested_users - current_user.invalid_users
		@all_users = current_user.search_users("") - @requested - current_user.followings
		@title = "All Users"
	end

	def follow_toggle
		@id = params[:id]
		@user = User.find(@id)
		record = FollowingList.find_record(current_user.id,params[:id])
		if record.present?
			if record.follow_status != "blocked"
				record.destroy
			end
		else
			FollowingList.create!(from_id: current_user.id, to_id: params[:id], follow_status: "requested")
		end
	end

	def cancel_request
		@id = params[:id]
		record = FollowingList.find_record(params[:id],current_user.id)
		if record.present?
			record.destroy
			respond_to do |format|
				format.js { render :accept_request }
			end
		end
	end

	def accept_request
		@id = params[:id]
		record = FollowingList.find_record(params[:id],current_user.id)
		if record.present?
			record.accepted!
		end
	end

	def search_users
		if params[:name].blank?
			index
		else
			@all_users = current_user.search_users(params[:name])
			@title = "Search Result"
		end
	end

	def followings_list
		@users = current_user.followings
	end

	def followers_list
		@users = current_user.followers
	end

	def block_user
		@id = params[:id]
		record = FollowingList.find_record(params[:id],current_user.id)
		if record.present?
			if record.requested?
				record.destroy
			end
		end
		record = FollowingList.find_record(current_user.id,params[:id])
		if record.present?
			record.blocked!
		else
			FollowingList.create!(from_id: current_user.id, to_id: params[:id], follow_status: "blocked")
		end
	end

	def unblock_user
		@id = params[:id]
		record = FollowingList.find_record(params[:id],current_user.id)
		if record.present?
			if record.accepted?
				record.destroy
			end
		end
		record = FollowingList.find_record(current_user.id,params[:id])
		if record.present?
			record.destroy
		end
	end

end


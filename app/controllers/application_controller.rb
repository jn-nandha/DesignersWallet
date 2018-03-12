class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def count
		if current_user != nil
			binding.pry
			@noti_count_chat = Chat.unread.where(receiver_id: current_user.id).pluck(:sender_id).uniq.count
			@noti_count_follow = FollowingList.requested.where(to_id: current_user.id).count
		end
	end

end

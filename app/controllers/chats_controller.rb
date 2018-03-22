class ChatsController < ApplicationController
	before_action :authenticate_user!
	def index
		all_recipients

		if @notified_users.count > 0
			@user = @notified_users.first
		elsif @followed_users.count > 0
			@user = @followed_users.first
		else
			@user = @all_users.first
		end
		@msgs = get_messages(@user)
		get_read(@msgs)
	end

	def msg
		all_recipients
		
		@user = User.find(params[:id])
		@msgs = get_messages(@user)
		get_read(@msgs)
	end

	def send_msg

		@user = User.find(params[:chat][:receiver_id])
		chat = Chat.new(chat_params)
		chat.sender_id = current_user.id
		chat.message_status = "unread"
		
		if params[:chat][:designs_id].present?
			chat.message_type = "image"
			chat.designs_id = params[:chat][:designs_id].split
		else
			chat.message_type = "text"
		end

		if (FollowingList.where(from_id: params[:chat][:receiver_id], to_id: current_user, block: true).count == 0) && (params[:chat][:body] != "" || params[:chat][:designs_id] != "")
			chat.save!
		end
		@msgs = get_messages(@user)
	end

	def search
		if params[:name].blank?
			@search_users = []
		else
			all = User.where("name LIKE ?","%#{params[:name]}%").pluck(:id).sort - [current_user.id]
			blocked = FollowingList.where(to_id: current_user, block: true).pluck(:from_id).sort
			@search_users = User.where(id: (all - blocked))
		end
	end

	def design
		uploaded_id = Design.where(user_id: current_user.id).pluck(:id)
		favourited_id = Favourite.where(user_id: current_user.id).pluck(:design_id)
		@designs = Design.find((uploaded_id + favourited_id).uniq)
	end


	private

	def chat_params
		params.require(:chat).permit(:body,:receiver_id)
	end

	def get_messages(user)
		Chat.where("(sender_id =? and receiver_id= ?) or (sender_id =? and receiver_id=?)", current_user.id, user.id, user.id, current_user.id).order('created_at ASC')
	end

	def get_read(msgs)
		msgs.where(receiver_id: current_user.id)
		msgs.each do |m|
			m.read!
		end
	end

	def all_recipients
		all = User.where.not(id: current_user.id).pluck(:id).sort
		blocked = FollowingList.where(to_id: current_user, block: true).pluck(:from_id).sort

		@all_users = User.where(id: (all - blocked))

		# followed = FollowingList.where(from_id: current_user.id, follow_status: "accepted").map(&:to).uniq
		from = Chat.where(sender_id: current_user.id).pluck(:receiver_id).uniq
		to = Chat.where(receiver_id: current_user.id).pluck(:sender_id).uniq
		followed = User.where(id: (from + to).uniq)

		@notified_users = Chat.where(receiver_id: current_user.id,message_status: "unread").order('created_at DESC').map(&:sender).uniq
		@followed_users = (followed - @notified_users).uniq
	end
end

class ChatController < ApplicationController

	def notification
		if current_user != nil
			n = Chat.where(receiver_id: current_user.id, receiver_status: "U").map(&:sender_id).uniq
			@users = User.where(id: n)
		else
			redirect_to new_user_session_path
		end
	end

	def chat_show
		@msgs = Chat.where("(receiver_id = ? AND sender_id = ?) OR (receiver_id = ? AND sender_id = ?)",current_user.id,params[:recp],params[:recp],current_user.id)
		@msgs.each do |m|
			if m.receiver_id == current_user.id
				m.receiver_status = "S"
			else
				m.sender_status = "S"
			end
			m.save
		end
	end

	def user_show
		if current_user != nil
			s = Chat.where(receiver_id: current_user.id).map(&:sender_id).uniq
			r = Chat.where(sender_id: current_user.id).map(&:receiver_id).uniq
			n = (s + r).uniq
			@users = User.where(id: n)
		else
			redirect_to new_user_session_path
		end
	end

	def create
		
	end

end

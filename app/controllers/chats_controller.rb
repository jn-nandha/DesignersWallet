class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :all_recipients, only: %i[index msg]

  def index
    @user =
      if @notified_users.count > 0
        @notified_users.first
      elsif @followed_users.count > 0
        @followed_users.first
      else
        @all_users.first
      end

    @msgs = @user.messages_with(current_user)
    mark_as_read!(@msgs)
  end

  def msg
    @user = User.find(params[:id])
    @msgs = @user.messages_with(current_user)
    mark_as_read!(@msgs)
  end

  def send_message
    @user = User.find(params[:chat][:receiver_id])
    new_chat_params = chat_params.dup
    new_chat_params[:sender_id] = current_user.id
    new_chat_params[:message_status] = 'unread'

    if params[:chat][:designs_id].present?
      new_chat_params[:message_type] = 'image'
      new_chat_params[:designs_id] = params[:chat][:designs_id].split
    else
      new_chat_params[:message_type] = 'text'
    end
    chat = Chat.new(new_chat_params)
    chat.save! if current_user.blocked_ids.exclude?(params[:chat][:receiver_id]) && (params[:chat][:body] != '' || params[:chat][:designs_id] != '')
    @msgs = @user.messages_with(current_user)
  end

  def search
    @search_users = if params[:name].blank?
                      []
                    else
                      current_user.search_users(params[:name])

                    end
  end

  def design
    @designs = current_user.uploaded_favourited_designs
  end

  private

  def chat_params
    params.require(:chat).permit(:body, :receiver_id)
  end

  def mark_as_read!(messages)
    messages.where(receiver_id: current_user.id).map(&:read!)
  end

  def all_recipients
    @all_users = current_user.search_users('')
    from = Chat.where(sender_id: current_user.id).pluck(:receiver_id).uniq
    to = Chat.where(receiver_id: current_user.id).pluck(:sender_id).uniq
    followed = User.where(id: (from + to).uniq).where(activation: 'true')
    @notified_users = Chat.where(receiver_id: current_user.id, message_status: 'unread')
                          .order('created_at DESC').map(&:sender).uniq
    @followed_users = (followed - @notified_users).uniq
  end
end

require 'will_paginate/array'
#all controller inherit this controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! 
  def count
    if current_user != nil
      @noti_count_chat = Chat.unread.where(receiver_id: current_user.id).pluck(:sender_id).uniq.count
      @noti_count_follow = FollowingList.requested.where(to_id: current_user.id).pluck(:from_id).uniq.count
    end
  end
end
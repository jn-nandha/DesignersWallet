class HomeController < ApplicationController
  def error; end

  def dashboard
    @cat = Category.all

    if current_user.activation
      design_selection = params[:design_selection]
      design_selection = "Following's Designs" if design_selection.nil?
      if design_selection == "Following's Designs"

        a = FollowingList.joins(:to)
                .where(from_id: current_user.id, follow_status: 'accepted')
                .map(&:to_id)
        @followings = User.where(id: a, activation: true)
        @designs = Design.joins(:user).where(user_id: @followings).order('updated_at DESC')
      elsif design_selection == 'All Designs'
        @designs = Design.all.order('updated_at DESC')
      end
    else
      redirect_to home_error_path
    end

  end


  def image_info
    if current_user.activation
      @users = User.where('id != ? and activation != ?', current_user.id, false)
      @design = Design.find(params[:design_id])
      @complain = Feedback.find_by(user_id: current_user.id, design_id: params[:design_id])
    end
  end

  def share_design
    users = User.where(id: params[:selectedusers])
    count = 0
    if users.count > 0
      users.each do |u|
        c = Chat.new(sender_id: current_user.id, receiver_id: u.id, designs_id: [params[:design_id]], message_status: 'unread', message_type: 'image', body: '')
        count += 1 if c.save!
      end
      flash[:success] = "You have shared this design to #{count} user"
    else
      flash[:danger] = 'Please select users to share this design'
    end
  end

  def search
    unless params[:categories].nil?
      @designs = Design.includes(:categories).where(categories: {id: params[:categories]})
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

end

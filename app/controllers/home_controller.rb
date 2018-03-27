class HomeController < ApplicationController
  def dashboard
    return unless current_user.activation
    @cat = Category.all
      return unless current_user.activation
      design_selection = params[:design_selection]
      design_selection ||= "Following's Designs"
      if design_selection == "Following's Designs"
        @designs = current_user.followings_designs
        @title = "Followings Design"
      elsif design_selection == "All Designs"
        @designs = current_user.all_designs
        @title = "All Design"
      end 
  end

  def image_info
    return unless current_user.activation
    @users = current_user.search_users("")
    @design = Design.find(params[:design_id])
    @complain =  current_user.feedback(params[:design_id])
  end

  def share_design
    @flash_js = {}
    users = User.where(id: params[:selectedusers])
    count = 0
    if users.count > 0
      users.each do |user|
        chat = Chat.new(sender_id: current_user.id, receiver_id: user.id, designs_id: [params[:design_id]], message_status: 'unread', message_type: 'image', body: '')
        count += 1 if chat.save!
      end
      @flash_js[:success] = "You have shared this design to #{count} user"
    else
      @flash_js[:danger] = 'Please select users to share this design'
    end
  end

  def search
    categories = params[:categories].split(',')
    if params[:categories].present?
      @designs = Design.includes(:categories).where(categories: {cat_name: categories})
      @title = "Search Result"
    else
      @designs = current_user.all_designs
      @title = "All Design"
    end
  end
end

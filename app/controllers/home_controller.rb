class HomeController < ApplicationController
  def error
  end

  def dashboard
    return unless current_user.activation
    @cat = Category.all
      return unless current_user.activation
      design_selection = params[:design_selection]
      design_selection ||= "Following's Designs"
      if design_selection == "Following's Designs"
        @designs = Design.joins(:user).where(user_id: current_user.followings.pluck(:id)).order("updated_at DESC") 
      elsif design_selection == "All Designs"
        @designs = current_user.all_designs
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
      users.each do |u|
        c = Chat.new(sender_id: current_user.id,receiver_id: u.id,designs_id: [params[:design_id]],message_status: "unread",message_type: "image",body: "")
        if c.save!
          count += 1
        end   
      end   
      @flash_js[:success] = "You have shared this design to #{count} user"
    else
      @flash_js[:danger] = "Please select users to share this design"
    end
  end

  def search
    if params[:categories].nil?
    else
      @designs = Design.includes(:categories).where(categories: {id: params[:categories]})
    end
  end 

end

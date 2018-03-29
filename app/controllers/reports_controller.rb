class ReportsController < ApplicationController
	before_action :authenticate_admin! # here authenticate admin before action
    skip_before_action :authenticate_user! # here skip authenticate user in all methods

# def report
# 	   # @users = User.all.paginate(:page => params[:page], :per_page => 5)
# 	end

	def report
	    # @user = Feedback.where(["design_id LIKE ?","%#{params[:search]}%"])
		@feedback = Feedback.all.order("design_id")
		@cc = User.joins(:feedback)
		@total_repoart = Feedback.select(:design_id).map(&:design_id).uniq
		@ccuser = User.order("design_id")
		@ccdesign = Design.order("design_id")
		@deals = User.where(created_at: Date.today.all_day)
		@cat = Category.all.order("cat_name ASC")
		# @uacount = User.where("activation == true) 
	end
end
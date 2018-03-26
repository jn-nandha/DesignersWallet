class ReportsController < ApplicationController
	before_action :authenticate_admin! # here authenticate admin before action
  skip_before_action :authenticate_user! # here skip authenticate user in all methods

# def report
# 	   # @users = User.all.paginate(:page => params[:page], :per_page => 5)
# 	end

	def new
		
	before_action :authenticate_admin! # here authenticate admin before action
  skip_before_action :authenticate_user! # here skip authenticate user in all methods

end

	def report
		 @user = Feedback.where(["design_id LIKE ?","%#{params[:search]}%"])
		@feedback = Feedback.order("design_id")
		@cc = User.joins(:feedback)
		@total_repoart = Feedback.select(:design_id).map(&:design_id).uniq
		@ccuser = User.order("design_id")
	end


	# def create
		
	# end

end
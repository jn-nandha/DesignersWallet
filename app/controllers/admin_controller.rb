class AdminController < ApplicationController
	def addashboard
 	   @user = User.where(["name LIKE ?","%#{params[:search]}%"])
 		# @user = User.all
		@city = City.all
		@feedback = Feedback.order("design_id")
		#@ftot = Feedback.where(design_id: 1).uniq.count(:id)
		@total_repoart = Feedback.select(:design_id).map(&:design_id).uniq
	end
	def show
		@Feedbackid = Feedback.find(params[:id])
	end
	def allrepoarts
		@feedback = Feedback.order("design_id")
		@cc = User.joins(:feedback)
	end
end
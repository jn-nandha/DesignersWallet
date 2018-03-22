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
		 @user = Feedback.where(["design_id LIKE ?","%#{params[:search]}%"])
		@feedback = Feedback.order("design_id")
		@cc = User.joins(:feedback)
		@total_repoart = Feedback.select(:design_id).map(&:design_id).uniq
	end

	def showusers
	@city = City.all
	   @user = User.where(["name LIKE ?","%#{params[:search]}%"])
	   .or(User.where(["email LIKE ?","%#{params[:search]}%"]))
	   # .or(User.where(["c LIKE ?","%#{params[:search]}%"]))
	   
    #User.where(first_name: 'James', last_name: 'Scott').or(User.where(email: 'james@gmail.com'))
 
		# @user = User.where(["name LIKE ?","%#{params[:search]}%"])
 		# @user = User.all
	
	end
end
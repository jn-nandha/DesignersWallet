class AdminController < ApplicationController
	def addashboard
		@user = User.all
		@city = City.all
		 @feedback = Feedback.order("design_id")





		 @ftot = Feedback.where(design_id: 3).count(:id)
		# @feedback = Feedback.orde.select("Feedback.*, count(design_id)")
			
		# @feedback = feedback1.sort_by(&:design_id)
	end
end



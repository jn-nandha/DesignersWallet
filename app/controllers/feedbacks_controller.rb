class FeedbacksController < ApplicationController


	def like
		@did = params[:design_id]
		if current_user.activation
			a= Feedback.find_by(user_id: current_user.id, design_id: params[:design_id])
			if a.nil?
				feedback = Feedback.new
				feedback.user_id = current_user.id
				feedback.design_id = params[:design_id]
				feedback.like = true
				feedback.save!
			else
			
				feedback = Feedback.find(a.id)
				if feedback.like == true
					feedback.like = false
				else
					feedback.like = true
				end
				feedback.save!
			end
		end

	end


	def complain
		if current_user.activation
			a= Feedback.find_by(user_id: current_user.id, design_id: params[:design_id])
			if a.nil?
				feedback = Feedback.new
				feedback.user_id = current_user.id
				feedback.design_id = params[:design_id]
				feedback.report = params[:feedback][:complain]
				feedback.save!
			else
			
				feedback = Feedback.find(a.id)
				feedback.report = params[:feedback][:complain]
				feedback.save!
			end
			@complain =  Feedback.find_by(user_id: current_user.id, design_id: params[:design_id])
		end

	end
end

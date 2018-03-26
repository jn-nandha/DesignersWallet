class FeedbacksController < ApplicationController
  def like
    @did = params[:design_id]
    retutn unless current_user.activation
      feedback= current_user.feedback(@did)
      if feedback.nil?
        feedback = Feedback.create!(user_id: current_user.id, design_id: params[:design_id],like: true)
      else
        feedback.update_attributes!(like: !feedback.like)
      end
    end

  def complain
    @flash_js= {}
    return unless current_user.activation
    feedback = current_user.feedback(params[:design_id])
    if params[:feedback][:complain].present?
      if feedback.nil?
        feedback = Feedback.create!(user_id: current_user.id, design_id: params[:design_id], report: params[:feedback][:complain])
        @flash_js[:success]= "complain successfully registered."
      else
        feedback.update!(report: params[:feedback][:complain])
        @flash_js[:success]= "complain successfully updated."
      end
    else
      if feedback.nil?
        @flash_js[:danger] = "write complain."
      else
        if feedback.report.nil?
          @flash_js[:danger] = "write complain."
        else
          @flash_js[:danger] = "unable to update complain."
        end
      end
    end
     @complain =  feedback
  end
end

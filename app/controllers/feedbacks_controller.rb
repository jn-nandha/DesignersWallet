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
    complain = params[:feedback][:complain]
    if complain.blank?
      @flash_js[:danger] = "write complain."
    else
      if feedback.present?
        feedback.update!(report: params[:feedback][:complain])
      else
        feedback = Feedback.create!(user_id: current_user.id, design_id: params[:design_id], report: params[:feedback][:complain])
      end
      @flash_js[:success]= "complain successfully registered."
    end
    @design = Design.find(params[:design_id])
    @complain = feedback
  end

end

module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find(params[:job_id])
      if @delayed_job
        render :json, { id: @delayed_job.id, progress_stage: @delayed_job[:progress_stage] , progress_max: @delayed_job[:progress_max], progress_current: @delayed_job[:progress_current] }
      else
        # render :status => 404
        raise "job id #{params[:job_id]} not found"
      end
    end

  end
end
module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find(params[:job_id])
      if @delayed_job
        resp = { id: @delayed_job.id.to_s,
                 progress_stage: @delayed_job[:progress_stage] ,
                 progress_max: @delayed_job[:progress_max],
                 progress_current: @delayed_job[:progress_current],
                 last_error: @delayed_job[:last_error]
        }
        render json: resp.to_json
      else
        # render :status => 404
        raise "job id #{params[:job_id]} not found"
      end
    end

  end
end
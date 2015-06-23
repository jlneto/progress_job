module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find(params[:job_id])
      if @delayed_job
        max = (@delayed_job[:progress_max].to_f || 100)
        percentage = !max.zero? ? @delayed_job[:progress_current] / max * 100 : 0
        render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
      else
        # render :status => 404
        raise "job id #{params[:job_id]} not found"
      end
    end

  end
end
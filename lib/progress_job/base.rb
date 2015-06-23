module ProgressJob
  class Base
    def initialize(progress_max = 100)
      @progress_max = progress_max
    end

    def before(job)
      @job = job
      update_column(job,:progress_max, @progress_max)
      update_column(job,:progress_current, 0)
    end

    def update_progress(step = 1)
      update_column(@job,:progress_current, @job[:progress_current] + step)
    end

    def update_stage(stage)
      update_column(@job,:progress_stage, stage)
    end

    def update_stage_progress(stage, step = 1)
      update_stage(stage)
      update_progress(step: step)
    end

    def update_progress_max(progress_max)
      update_column(@job,:progress_max, progress_max)
    end

    def error(job, exception)
      update_column(job,:progress_stage, exception.message)
    end

    def update_column(job, col,value)
      job[col] = value
      job.save
    end

  end
end

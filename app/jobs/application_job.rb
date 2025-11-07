class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  #
  def queue_name
    :default
  end

  # This is before the Delayed::Job record is actually created, so no job.id value yet
  def enqueue(_job)
    AppLog.info(self, tag: :delayed_job, message: 'Enqueue job', job: self.class, params:)
  end

  def failure(job)
    AppLog.error(self, tag: :delayed_job, message: 'Job failed permanently', job: self.class, params:, job_id: job.id, attempt: job.attempts,
                       job_duration: Time.zone.now - job.locked_at)
    # Necessary, so we can differentiate between a job that failed once and a job that failed every attempt
    Delayed::Job.find(job.id).update(permanently_failed: true)
  end

  def before(job)
    initialize_job_context(job)

    # For queued_duration, if the attempts = 0, updated_at is same as created_at, for attempts != 0, i.e job failed, the updated_at field will be the time the job failed
    AppLog.info(self, tag: :delayed_job, message: 'Before perform job', job: self.class, pid: Process.pid, memory: memory_consumption, params:, job_id: job.id,
                      attempt: job.attempts + 1, queued_duration: job.locked_at - job.updated_at)
  end

end

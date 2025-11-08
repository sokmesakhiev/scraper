# frozen_string_literal: true

Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 0.5
Delayed::Worker.max_attempts = 3
Delayed::Worker.read_ahead = 10
Delayed::Worker.max_run_time = 120.minutes
Delayed::Worker.default_queue_name = "default"
Delayed::Worker.delay_jobs = ->(_job) { !ActiveJob::Base.queue_adapter.is_a?(ActiveJob::QueueAdapters::TestAdapter) }
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(Rails.root.join("log/delayed_jobs.log"))
Delayed::Worker.backend = :active_record
Delayed::Worker.default_priority = 10

Delayed::Worker.queue_attributes = {
  default: { priority: 10 },
  notifications: { priority: 5 }
}

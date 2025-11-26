class KeywordFile < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_one_attached :original_file

  enumerize :status, in: [ "failed", "pending", "processing", "complete" ], default: :pending

  def refresh_status
    status = keywords.pluck(:status).uniq

    self.update!(status: :failed) if status.include?("failed")
    self.update!(status: :processing) if status.include?(%w[pending processing])

    self.update!(status: :complete)
  end
end

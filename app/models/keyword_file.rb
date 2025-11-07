class KeywordFile < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :keywords, dependent: :destroy
  has_one_attached :original_file

  enumerize :status, in: [ "failed", "pending", "processing", "complete" ], default: :pending
end

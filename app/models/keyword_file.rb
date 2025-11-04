class KeywordFile < ApplicationRecord
  belongs_to :user
  has_many :keywords
  has_one_attached :original_file
end

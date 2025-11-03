class KeywordFile < ApplicationRecord
  belongs_to :user

  has_many :keywords
  has_many :keyword_results, through: :keywords

  has_one_attached :original_file
end

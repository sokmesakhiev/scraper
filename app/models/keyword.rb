class Keyword < ApplicationRecord
  belongs_to :keyword_file
  has_many :keyword_results

  validates :term, presence: true
end

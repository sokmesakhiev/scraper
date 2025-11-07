class ScrapingKeywordsJob < ApplicationJob
  def perform(keyword_file_id:, terms:)
    keyword_file = KeywordFile.find_by(id: keyword_file_id)

    return if keyword_file.blank?

    terms.map do |term|
      keyword = keyword_file.keywords.find_by(term:)

      next if keyword.blank?

      mark_keyword_as_processing(keyword)

      response = Scrapers::Bing::Scraper.new(term:).process

      keyword.update!(
        status: :complete,
        total_ads: response[:total_ads],
        total_link: response[:total_link],
        html_code: response[:html_code]
      )
    end
  end

  private

  attr_reader :terms, :keyword_file_id

  def mark_keyword_as_processing(keyword)
    keyword.update!(status: :processing)
  end
end

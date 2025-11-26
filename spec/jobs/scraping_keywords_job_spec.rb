# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScrapingKeywordsJob, type: :job, vcr: { cassette_name: 'bing_scraper' } do
  describe '#perform_later' do
    it 'scraps data from Bing' do
      keyword_file = create(:keyword_file)
      keyword = create(:keyword, keyword_file:, term: 'nimble', total_ads: nil, total_link: nil, html_code: nil)

      described_class.perform_later(keyword_file_id: keyword_file.id, terms: [ 'nimble' ])

      expect(keyword.reload.total_ads).to eq(8)
      expect(keyword.total_link).to eq(7)
      expect(keyword.html_code).to be_present
      expect(keyword_file.reload.status).to eq("complete")
    end
  end
end

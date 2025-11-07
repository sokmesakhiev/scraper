# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scrapers::Bing::Scraper do
  describe '.process' do
    it 'scraps data from Bing', vcr: { cassette_name: 'bing_scraper' } do
      scraper = described_class.new(term: 'nimble')

      response = scraper.process

      expect(response[:total_ads]).to eq(8)
      expect(response[:total_links]).to eq(7)
      expect(response[:html_code]).to be_present
    end
  end
end

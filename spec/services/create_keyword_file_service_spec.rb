# frozen_string_literal: true

require 'rails_helper'

describe CreateKeywordFileService do
  describe '#call' do
    it 'creates keyword file' do
      allow(ScrapingKeywordsJob).to receive(:perform_later)

      user = create(:user)
      csv_content = 'nimble,facebook,google'

      keyword_file = described_class.call(filename: 'keywords.csv', csv_content:, user: user)

      expect(keyword_file).to be_persisted
      expect(keyword_file.name).to eq('keywords.csv')
      expect(keyword_file.errors).to be_empty
      expect(keyword_file.user).to eq(user)
      expect(keyword_file.keywords.size).to eq(3)
      expect(ScrapingKeywordsJob).to have_received(:perform_later).with(keyword_file_id: keyword_file.id, terms: [ 'nimble', 'facebook', 'google' ])
    end
  end
end

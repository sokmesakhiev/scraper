# frozen_string_literal: true

require 'rails_helper'

describe CreateKeywordFileService do
  describe '#call' do
    it 'creates keyword file' do
      allow(ScrapingKeywordsJob).to receive(:perform_later)

      user = create(:user)
      # nimble,facebook,google
      file = fixture_file_upload('spec/fixtures/files/keywords.csv', 'text/csv')

      keyword_file = described_class.call(file:, user: user)

      expect(keyword_file).to be_persisted
      expect(keyword_file.errors).to be_empty
      expect(keyword_file.user).to eq(user)
      expect(keyword_file.keywords.size).to eq(3)
      expect(ScrapingKeywordsJob).to have_received(:perform_later).with(keyword_file_id: keyword_file.id, terms: ['nimble', 'facebook', 'google'])
    end
  end
end

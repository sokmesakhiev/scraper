# frozen_string_literal: true

require 'rails_helper'

describe CreateKeywordFile do
  describe '#call' do
    it 'creates keyword file' do
      user = create(:user)
      file = fixture_file_upload('spec/fixtures/files/keywords.csv', 'text/csv')

      keyword_file = described_class.call(file:, user: user)

      expect(keyword_file).to be_persisted
      expect(keyword_file.errors).to be_empty
      expect(keyword_file.user).to eq(user)
    end
  end
end

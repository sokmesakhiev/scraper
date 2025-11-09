# frozen_string_literal: true

require 'rails_helper'
require_relative 'e2e_helper'

describe 'Keyword files', type: :feature do
  let(:email) { 'ksokmesa@gmail.com' }
  let(:password) { '123456' }
  let!(:user) { create(:user, email:, password:, password_confirmation: password) }
  let!(:keyword_file) { create(:keyword_file, user:, name: 'test.csv') }
  let!(:other_keyword_file) { create(:keyword_file, user:, name: 'example.csv') }

  it 'lists files' do
    login(email:, password:)

    expect(page).to have_content('test.csv')
    expect(page).to have_content('example.csv')
  end

  it 'filters files' do
    login(email:, password:)
    fill_in 'query', with: 'test'
    click_button 'search-button'

    expect(page).to have_content('test.csv')
    expect(page).not_to have_content('example.csv')
  end

  it 'uploads a file' do
    login(email:, password:)

    click_button "Upload File"

    attach_file('', Rails.root.join('spec/fixtures/files/keywords.csv'))
    click_button 'Upload'

    expect(page).to have_content('keywords.csv')
  end
end

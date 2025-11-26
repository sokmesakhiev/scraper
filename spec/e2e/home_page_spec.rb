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
    expect(user.keyword_files.size).to eq(3)
    expect(user.keyword_files.last.name).to eq('keywords.csv')
  end

  it 'deltes a file' do
    login(email:, password:)

    page.accept_confirm do
      click_link "delete-#{other_keyword_file.id}"
    end

    expect(page).not_to have_content('keywords.csv')
    expect(user.keyword_files.size).to eq(1)
    expect(user.keyword_files.find_by(name: 'example.csv')).to be_nil
  end

  it 'downloads a file' do
    login(email:, password:)
    link = find("#download-#{keyword_file.id}")

    expect(link[:href]).to eq("#{Capybara.app_host}#{keyword_file_download_path(keyword_file)}")
  end
end

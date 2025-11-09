# frozen_string_literal: true

require 'rails_helper'
require_relative 'e2e_helper'

describe 'Keyword', type: :feature do
  let(:email) { 'ksokmesa@gmail.com' }
  let(:password) { '123456' }
  let!(:user) { create(:user, email:, password:, password_confirmation: password) }
  let!(:keyword_file) { create(:keyword_file, user:, name: 'test.csv') }
  let!(:nimble_keyword) { create(:keyword, keyword_file:, term: 'nimble', html_code: 'Nimble') }
  let!(:other_keyword_file) { create(:keyword_file, user:, name: 'example.csv') }
  let!(:apple_keyword) { create(:keyword, keyword_file: other_keyword_file, term: 'apple', html_code: 'APPLE') }
  before do
    login(email:, password:)

    click_link "keywords-menu"
  end

  it 'lists terms for different files' do
    expect(page).to have_content('nimble')
    expect(page).to have_content('apple')
  end

  it 'filters terms' do
    fill_in 'query', with: 'nimble'
    click_button 'search-button'

    expect(page).to have_content('nimble')
    expect(page).not_to have_content('apple')
  end

  it 'deletes a term' do
    page.accept_confirm do
      click_link "delete-#{apple_keyword.id}"
    end

    expect(page).to have_content('nimble')
    expect(page).not_to have_content('apple')
  end

  it 'displays a html code' do
    click_button "view-html-#{apple_keyword.id}"

    expect(page).to have_content('APPLE')
  end
end

# frozen_string_literal: true

require 'rails_helper'
require_relative 'e2e_helper'

describe 'User authentication', type: :feature do
  let(:email) { 'ksokmesa@gmail.com' }
  let(:password) { '123456' }
  let!(:user) { create(:user, email:, password:, password_confirmation: password) }

  context 'incorrect credentials' do
    it 'does not log in' do
      visit '/'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: "foobar"
      click_button 'Sign in'

      expect(page).to have_content("Invalid Email or password.")
    end
  end

  context 'correct credentials' do
    it 'logs in' do
      visit '/'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      click_button 'Sign in'

      expect(page).to have_content("Welcome #{email}")
    end
  end

  context 'logout' do
    it 'logs out' do
      visit '/'
      login(email:, password:)
      page.accept_confirm do
        click_link 'Sign out'
      end

      expect(page).to have_content("Sign in to Bing Scraper")
    end
  end
end

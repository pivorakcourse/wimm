# frozen_string_literal: true

require 'rails_helper'

feature 'Create record: ' do
  context 'With autorization' do
    let!(:current_user) { assume_logged_user }
    let!(:account) { create(:account, user_id: current_user.id) }
    let!(:category) { create(:category, user_id: current_user.id) }
    let!(:correct_amount) { 1500 }
    let!(:incorrect_amount) { 0 }
    let!(:string_amount) { 'Fake string' }

    scenario 'Page have content amount' do
      visit app_dashboard_path

      expect(page).to have_content('Amount')
    end

    scenario 'Create record with zero amount' do
      visit app_dashboard_path
      fill_in 'Amount', with: incorrect_amount
      click_button 'Submit'

      expect(page).to have_content('record can`t be zero')
    end

    scenario 'Create record with string amount' do
      visit app_dashboard_path
      fill_in 'Amount', with: string_amount
      click_button 'Submit'

      expect(page).to have_content('Record can`t be string')
    end

    scenario 'Create record with correct amount' do
      visit app_dashboard_path

      fill_in 'record_amount', with: correct_amount
      click_button 'Submit'

      created_record = Record.last

      expect(page).to have_content('Record was successfully created')
      expect(created_record.amount).to eq correct_amount
      expect(created_record.category_id).to eq category.id
      expect(created_record.account_id).to eq account.id
    end
  end

  context 'Without autorization' do
    scenario 'Visit records page' do
      visit '/app/records'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

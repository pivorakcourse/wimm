# frozen_string_literal: true

require 'rails_helper'

feature 'Create record: ' do
  context 'With autorization' do
    let!(:current_user) { assume_logged_user }
    let!(:account) { create(:account, user_id: current_user.id) }
    let!(:category) { create(:category, user_id: current_user.id) }
    let!(:income_category) { create(:category, :income_category, user_id: current_user.id) }
    let!(:record) { create(:record, user_id: current_user.id, category_id: category.id, account_id: account.id) }
    let!(:correct_amount) { 1500 }
    let!(:incorrect_amount) { 0 }
    let!(:string_amount) { 'Fake string' }

    scenario 'Page have content amount' do
      visit user_root_path

      expect(page).to have_content('Amount')
    end

    scenario 'Create record with zero amount' do
      visit user_root_path
      within('form#withdraw-form') do
        fill_in 'Amount', with: incorrect_amount
        click_button 'Submit'
      end

      expect(page).to have_content('record can`t be zero')
    end

    scenario 'Create income record with zero amount' do
      visit user_root_path
      within('form#income-form') do
        fill_in 'Amount', with: incorrect_amount
        click_button 'Submit'
      end

      expect(page).to have_content('record can`t be zero')
    end

    scenario 'Create record with string amount' do
      visit user_root_path
      within('form#withdraw-form') do
        fill_in 'Amount', with: string_amount
        click_button 'Submit'
      end

      expect(page).to have_content('Record can`t be string')
    end

    scenario 'Create income record with string amount' do
      visit user_root_path
      within('form#income-form') do
        fill_in 'Amount', with: string_amount
        click_button 'Submit'
      end

      expect(page).to have_content('Record can`t be string')
    end

    scenario 'Create record with correct amount' do
      visit user_root_path

      within('form#withdraw-form') do
        fill_in 'record_amount', with: correct_amount
        click_button 'Submit'
      end

      created_record = Record.last

      expect(page).to have_content('Record was successfully created')
      expect(created_record.amount).to      eq(-correct_amount)
      expect(created_record.category_id).to eq category.id
      expect(created_record.account_id).to  eq account.id

      visit 'app/records'
      expect(page).to have_content(correct_amount)
      expect(page).to have_content(category.name)
      expect(page).to have_content(account.name)
    end

    scenario 'Create income record with correct amount' do
      visit user_root_path

      within('form#income-form') do
        fill_in 'record_amount', with: correct_amount
        click_button 'Submit'
      end

      created_record = Record.last

      expect(page).to have_content('Record was successfully created')
      expect(created_record.amount).to      eq correct_amount
      expect(created_record.category_id).to eq income_category.id
      expect(created_record.account_id).to  eq account.id

      visit 'app/records'
      expect(page).to have_content(correct_amount)
      expect(page).to have_content(income_category.name)
      expect(page).to have_content(account.name)
    end

    scenario 'Dasboard have last records' do
      visit user_root_path

      within('form#withdraw-form') do
        fill_in 'record_amount', with: correct_amount
        click_button 'Submit'
      end

      expect(page).to have_content(record.amount)
      expect(page).to have_content(record.account.name)
      expect(page).to have_content(record.category.name)
      expect(page).to have_content(record.created_at.strftime('%d-%m at %H:%M'))
    end
  end

  context 'Without autorization' do
    scenario 'Visit records page' do
      visit '/app/records'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

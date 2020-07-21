# frozen_string_literal: true

require 'rails_helper'

feature 'Update record: ' do
  context 'With autorization' do
    let!(:current_user) { assume_logged_user }
    let!(:account) { create(:account, user_id: current_user.id) }
    let!(:category) { create(:category, user_id: current_user.id) }
    let!(:record) { create(:record, user_id: current_user.id, category_id: category.id, account_id: account.id) }
    let!(:another_amount) { 150 }
    let!(:incorrect_amount) { 0 }

    scenario 'Edit record' do
      visit records_path
      click_link 'Edit'
      fill_in 'New record amount', with: another_amount
      click_button 'Submit'

      expect(page).to have_content('Record has been updated')
    end

    scenario 'Edit record with incorrect ammount' do
      visit records_path
      click_link 'Edit'
      fill_in 'New record amount', with: incorrect_amount
      click_button 'Submit'

      expect(page).to have_content('Record can`t be string and record can`t be zero')
    end
  end

  context 'Without autorization' do
    scenario 'Visit records page' do
      visit '/app/records'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

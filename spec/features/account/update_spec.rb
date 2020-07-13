# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account' do
  context 'With autorization' do
    let(:valid_params) { { name: 'TestAccount' } }
    let(:invalid_params) { { name: 'T' } }
    let!(:user) { assume_logged_user }
    let!(:account) { Account.create(name: 'TestAccount', user_id: user.id) }
    before { visit accounts_path }

    scenario 'Allows access to page for update of account' do
      expect(page).to have_current_path '/app/accounts'
      expect(page).to have_link('Edit')
    end

    scenario 'Update account with valid params' do
      click_link 'Edit'
      fill_in :account_name, with: valid_params[:name]
      click_button 'Update Account'

      expect(page).to have_content('Account has been updated')
    end

    scenario 'Update account with invalid params' do
      click_link 'Edit'
      fill_in :account_name, with: invalid_params[:name]
      click_button 'Update Account'

      expect(page).to have_content('Account not updated')
    end
  end

  context 'Without autorization' do
    scenario 'Visit account page' do
      visit '/app/accounts'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

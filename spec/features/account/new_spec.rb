# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account' do
  context 'With autorization' do
    let(:valid_params) { { name: 'TestAccount' } }
    let(:invalid_params) { { name: 'T', balance: '123.123' } }
    before { assume_logged_user }

    scenario 'Allows access to page for create of account' do
      visit new_account_path

      expect(page).to have_content('Create account:')
    end

    scenario 'Create correct account' do
      visit new_account_path

      fill_in :account_name, with: valid_params[:name]
      click_button 'Create Account'

      expect(page).to have_content('Account has been created')
    end

    scenario 'Create incorrect account' do
      visit new_account_path

      fill_in :account_name, with: invalid_params[:name]
      click_button 'Create Account'

      expect(page).to have_content('Account not created')
    end
  end

  context 'Without autorization' do
    scenario 'Visit account page' do
      visit '/app/accounts'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

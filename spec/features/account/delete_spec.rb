# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account' do
  let(:valid_params) { { name: 'TestAccount' } }
  let(:invalid_params) { { name: 'T', balance: '123.123' } }
  let!(:account) { Account.create(name: 'TestAccount', user_id: user.id) }
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

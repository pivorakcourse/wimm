# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account' do
  context 'With autorization' do
    let!(:user) { assume_logged_user }
    let!(:account) { create(:account, :with_money, user_id: user.id, name: 'Mono') }
    let!(:account_cash) { create(:account, user_id: user.id) }
    let!(:transfer) { 100 }
    let!(:income_transfer_category) do
      create(
        :category,
        :income_transfer_category,
        user_id: user.id
      )
    end

    let!(:expense_transfer_category) do
      create(
        :category,
        :expense_transfer_category,
        user_id: user.id
      )
    end

    before { visit user_root_path }

    scenario 'Page have content transfer' do
      expect(page).to have_content('Transfer')
      expect(page).to have_button('Submit')
    end

    scenario 'Create transfer with zero amount' do
      within('form#transfer-form') do
        fill_in 'Transfer', with: transfer
        click_button 'Submit'
      end

      expect(account_cash.balance).to eq(0)
    end

    scenario 'Successfull transfer' do
      within('form#transfer-form') do
        select('Mono', from: 'transfers_from_account_id')
        select('Cash', from: 'transfers_to_account_id')
        fill_in 'Transfer', with: transfer
        click_button 'Submit'
      end

      expect(account_cash.reload.balance).to eq(transfer)
      expect(account.reload.balance).to eq(-transfer)
      expect(CalculateUserTotalBalanceService.new(user).call).to eq(0)
    end
  end
end

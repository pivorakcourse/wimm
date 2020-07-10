# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account' do
  let!(:user)     { assume_logged_user }
  let!(:account)  { Account.create(name: 'TestAccount', user_id: user.id) }
  let!(:category) { create(:category, user_id: user.id) }
  let(:record)    { Record.create(amount: 100, category_id: category.id, account_id: account.id, user_id: user.id) }

  before { visit accounts_path }

  context 'Zero record account' do
    scenario 'Button Delete visible for empty records account' do
      expect(page).to have_link('Delete')
    end

    scenario 'Account disappear after click Delete link' do
      click_link 'Delete'

      expect(page).not_to have_content(account.name)
      expect(page).to have_content('Account has been deleted')
    end
  end

  context 'Account with records' do
    scenario 'Button Delete invisible for account with records' do
      record
      visit accounts_path

      expect(page).not_to have_link('Delete')
    end
  end
end

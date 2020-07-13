# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account' do
  let!(:user)     { assume_logged_user }
  let!(:account)  { create(:account, user_id: user.id) }
  let!(:category) { create(:category, user_id: user.id) }
  let(:record)    { create(:record, category_id: category.id, account_id: account.id, user_id: user.id) }

  before { visit accounts_path }

  context 'Zero record account' do
    scenario 'Account disappear after click Delete link' do
      expect(page).to have_link('Delete')

      expect do
        click_link 'Delete'
      end.to change { Account.count }.from(1).to(0)

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

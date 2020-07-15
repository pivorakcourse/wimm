# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard' do
  let!(:user) { assume_logged_user }
  let!(:account) { create(:account, user: user) }

  before { visit user_root_path }

  scenario 'dispaly accounts' do
    within('table#accounts-table') do
      expect(page).to have_xpath('.//tr', count: user.accounts.count)
      expect(page).to have_xpath('.//td', text: user.accounts.last.name)
        .and have_xpath('.//td', text: user.accounts.last.balance)
    end
  end
end

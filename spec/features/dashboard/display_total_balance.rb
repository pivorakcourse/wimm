# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard' do
  let!(:user) { assume_logged_user }
  let!(:account) { create(:account, user: user, balance: 100) }
  let!(:account_2) { create(:account, user: user, balance: -250) }
  let!(:account_3) { create(:account, user: user, balance: 200) }

  before { visit user_root_path }

  scenario 'display total balance' do
    within('h3#total-balance') do
      expect(page).to have_content(50)
    end
  end
end

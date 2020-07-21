# frozen_string_literal: true

require 'rails_helper'

feature 'Delete record: ' do
  context 'With autorization' do
    let!(:current_user) { assume_logged_user }
    let!(:account) { create(:account, user_id: current_user.id) }
    let!(:category) { create(:category, user_id: current_user.id) }
    let!(:record) { create(:record, user_id: current_user.id, category_id: category.id, account_id: account.id) }

    scenario 'Delete record' do
      visit records_path
      click_link 'Delete'

      expect(page).to have_content('Record has been deleted')
    end
  end

  context 'Without autorization' do
    scenario 'Visit records page' do
      visit '/app/records'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

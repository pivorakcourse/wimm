# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Monthly summary report' do
  context 'With autorization' do
    let!(:user) { assume_logged_user }

    before { visit reports_monthly_summary_path }

    scenario 'display this year' do
      click_link 'This year'

      expect(page.find('#from').value).to eq(Date.today.at_beginning_of_year.to_s)
      expect(page.find('#to').value).to eq(Date.today.at_end_of_year.to_s)
      expect(page).to have_current_path(reports_monthly_summary_path(
                                          from: Date.today.at_beginning_of_year.to_s,
                                          to:   Date.today.at_end_of_year.to_s
                                        ))
    end

    scenario 'display previous year' do
      click_link 'Previous year'

      expect(page.find('#from').value).to eq(Date.today.at_beginning_of_year.last_year.to_s)
      expect(page.find('#to').value).to eq(Date.today.at_end_of_year.last_year.to_s)
      expect(page).to have_current_path(reports_monthly_summary_path(
                                          from: Date.today.at_beginning_of_year.last_year.to_s,
                                          to:   Date.today.at_end_of_year.last_year.to_s
                                        ))
    end
  end

  context 'Without autorization' do
    scenario 'Page redirect to sign in' do
      visit reports_root_path

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

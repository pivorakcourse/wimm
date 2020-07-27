# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category reports' do
  let!(:user) { assume_logged_user }

  before { visit reports_category_reports_path }

  scenario 'display this month' do
    click_link 'this month'

    expect(page.find('#from').value).to eq(Date.today.at_beginning_of_month.to_s)
    expect(page.find('#to').value).to eq(Date.today.to_s)
    expect(page).to have_current_path(reports_category_reports_path(
                                        from: Date.today.at_beginning_of_month.to_s,
                                        to:   Date.today.to_s
                                      ))
  end

  scenario 'display previous month' do
    click_link 'previous month'

    expect(page.find('#from').value).to eq(Date.today.at_beginning_of_month.last_month.to_s)
    expect(page.find('#to').value).to eq(Date.today.at_end_of_month.last_month.to_s)
    expect(page).to have_current_path(reports_category_reports_path(
                                        from: Date.today.at_beginning_of_month.last_month.to_s,
                                        to:   Date.today.at_end_of_month.last_month.to_s
                                      ))
  end

  scenario 'display this year' do
    click_link 'this year'

    expect(page.find('#from').value).to eq(Date.today.at_beginning_of_year.to_s)
    expect(page.find('#to').value).to eq(Date.today.at_end_of_year.to_s)
    expect(page).to have_current_path(reports_category_reports_path(
                                        from: Date.today.at_beginning_of_year.to_s,
                                        to:   Date.today.at_end_of_year.to_s
                                      ))
  end

  scenario 'display previous year' do
    click_link 'previous year'

    expect(page.find('#from').value).to eq(Date.today.at_beginning_of_year.last_year.to_s)
    expect(page.find('#to').value).to eq(Date.today.at_end_of_year.last_year.to_s)
    expect(page).to have_current_path(reports_category_reports_path(
                                        from: Date.today.at_beginning_of_year.last_year.to_s,
                                        to:   Date.today.at_end_of_year.last_year.to_s
                                      ))
  end
end

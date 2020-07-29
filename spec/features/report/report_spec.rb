# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports' do
  context 'With autorization' do
    let!(:user) { assume_logged_user }

    scenario 'Page have url reports' do
      visit reports_root_path

      expect(page).to have_link('Categorized expenses')
      expect(page).to have_link('Monthly balance')
      expect(page).to have_link('Yearly expenses')
    end
  end

  context 'Without autorization' do
    scenario 'Page redirect to sign in' do
      visit reports_root_path

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

feature 'Favorite account' do
  let!(:user) { assume_logged_user }
  let!(:account) { create(:account, user: user) }

  scenario 'Have link to favorite account' do
    visit "/app/accounts/#{account.id}/edit"

    click_link 'Make it favorite'
    expect(page).to have_current_path '/app/accounts'
  end
end

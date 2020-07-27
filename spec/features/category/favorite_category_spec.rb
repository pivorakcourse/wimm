# frozen_string_literal: true

require 'rails_helper'

feature 'Favorite category' do
  let!(:user) { assume_logged_user }
  let!(:category) { create(:category, user: user) }

  scenario 'Have link to favorite category' do
    visit "/app/categories/#{category.id}/edit"

    click_link 'Make it favorite'
    expect(page).to have_current_path '/app/categories'
  end
end

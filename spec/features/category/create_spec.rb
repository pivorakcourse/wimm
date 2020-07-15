# frozen_string_literal: true

require 'rails_helper'

feature 'Create category: ' do
  context 'With autorization' do
    let(:category_name) { 'Food' }
    before { assume_logged_user }

    scenario 'Have Create Category button' do
      visit '/app'
      click_link 'Categories', href: '/app/categories'

      expect(page).to have_current_path '/app/categories'
      expect(page).to have_link('Add')
    end

    scenario 'Expected category form to have button add' do
      visit 'app/categories'
      click_link 'Add'

      expect(page).to have_field('New category name')
      expect(page).to have_button('Submit')
    end

    scenario 'Add new category' do
      visit 'app/categories'
      click_link 'Add'
      fill_in 'New category name', with: category_name
      click_button 'Submit'

      expect(page).to have_content(category_name)
      expect(current_path).to eq('/app/categories')
    end
  end

  context 'Without autorization' do
    scenario 'Visit categories page' do
      visit '/app/categories'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

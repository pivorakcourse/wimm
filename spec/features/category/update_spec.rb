# frozen_string_literal: true

require 'rails_helper'

feature 'Update category: ' do
  context 'With autorization' do
    let(:valid_name)   { 'Bills' }
    let(:invalid_name) { '' }
    let!(:user)        { assume_logged_user }
    let!(:category)    { create(:category, user_id: user.id) }
    before { visit categories_path }

    scenario "Have 'Edit' button" do
      expect(page).to have_current_path '/app/categories'
      expect(page).to have_link('Add category')
      expect(page).to have_link('Edit')
    end

    scenario 'Expected edit form to have button update_category' do
      click_link 'Edit'

      expect(page).to have_field('Name')
      expect(page).to have_button('Update Category')
    end

    scenario 'Update category_name with valid name' do
      click_link 'Edit'
      fill_in 'Name', with: valid_name
      click_button 'Update Category'

      expect(page).to have_content(valid_name)
      expect(page).not_to have_content(category.name)
      expect(current_path).to eq('/app/categories')
    end

    scenario 'Update category_name with invalid name' do
      click_link 'Edit'
      fill_in 'Name', with: invalid_name
      click_button 'Update Category'

      expect(page).to have_content('')
      expect(current_path).to eq("/app/categories/#{Category.last.id}")
    end
  end

  context 'Without autorization' do
    scenario 'Visit categories page' do
      visit '/app/categories'

      expect(page).to have_current_path '/users/sign_in'
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

feature 'Create category: ' do
  let(:category_name) { 'Food' }
  before { assume_logged_user }

  scenario 'Have add_category button' do
    visit '/app'
    click_link 'Categories', href: '/categories'

    expect(page).to have_current_path '/categories'
    expect(page).to have_link('Add category')
  end

  scenario 'Expected category form to have button add' do
    visit '/categories'
    click_link 'Add category'

    expect(page).to have_field('Name')
    expect(page).to have_button('Add')
  end

  scenario 'Add new category' do
    visit '/categories'
    click_link 'Add category'
    fill_in 'Name', with: category_name
    click_button 'Add'

    expect(page).to have_content(category_name)
    expect(current_path).to eq('/categories')
  end
end

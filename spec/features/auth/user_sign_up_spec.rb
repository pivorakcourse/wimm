# frozen_string_literal: true

require 'rails_helper'

feature 'Registration flow: ' do
  let!(:user_attr) { attributes_for(:user) }

  scenario 'User is signing up with correct data' do
    visit('/users/sign_up')

    within('#new_user') do
      fill_in 'Email', with: user_attr[:email]
      fill_in 'Password', with: user_attr[:password]
      fill_in 'Confirm password', with: user_attr[:password]
    end

    click_button 'Register'

    expect(page).to have_current_path '/app'
  end

  scenario 'User is signing up without filling required information' do
    visit('/users/sign_up')
    click_button 'Register'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'User is signing up with already used email' do
    visit('/users/sign_up')
    within('#new_user') do
      fill_in 'Email', with: user_attr[:email]
      fill_in 'Password', with: user_attr[:password]
      fill_in 'Confirm password', with: user_attr[:password]
    end

    click_button 'Register'
    visit('/app')
    click_link 'Logout'
    visit('/users/sign_up')

    within('#new_user') do
      fill_in 'Email', with: user_attr[:email]
      fill_in 'Password', with: '123456'
      fill_in 'Confirm password', with: '123456'
    end

    click_button 'Register'

    expect(page).to have_content 'Email has already been taken'
  end
end

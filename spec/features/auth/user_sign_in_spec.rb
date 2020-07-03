# frozen_string_literal: true

require 'rails_helper'

feature 'Authorization flow: ' do
  let!(:user) { create(:user) }
  let(:other_user) { { email: 'ihor@example.com', password: '123456' } }

  scenario 'Signing in with correct credentials' do
    visit '/users/sign_in'

    within('#new_user') do
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
    end

    click_button 'Enter'

    expect(page).to have_content 'Home'
    expect(current_path).to eql('/')
  end

  scenario 'Signing in as unregistered user' do
    visit '/users/sign_in'

    within('#new_user') do
      fill_in 'Email',    with: other_user[:email]
      fill_in 'Password', with: other_user[:password]
    end

    click_button 'Enter'

    expect(current_path).to eql('/users/sign_in')
  end
end

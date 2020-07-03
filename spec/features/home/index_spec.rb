# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test homepage' do
  scenario 'Navigation menu in loggined user' do
    user = assume_logged_user

    visit '/users/sign_in'

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_link 'Dashboard', href: '/app'
    expect(page).to have_link 'Accounts'
    expect(page).to have_link 'Records'
    expect(page).to have_link 'Categories'
    expect(page).to have_link 'Reports'
    expect(page).to have_link 'Logout', href: '/users/sign_out'
  end

  scenario 'Navigation menu in unloggined user' do
    visit '/'

    expect(page).to have_link 'Pivorak', href: 'https://pivorak.com'
    expect(page).to have_link 'Login', href: '/users/sign_in'
    expect(page).to have_link 'Registration', href: '/users/sign_up'
  end
end

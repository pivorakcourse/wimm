# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test homepage' do
  scenario 'Navigation menu in loggined user' do
    assume_logged_user

    visit '/'

    expect(page).to have_link 'Dashboard', href: '/app'
    expect(page).to have_link 'Accounts'
    expect(page).to have_link 'Records'
    expect(page).to have_link 'Categories'
    expect(page).to have_link 'Reports'
    expect(page).to have_link 'Logout', href: '/users/sign_out'
    expect(page).not_to have_link 'Pivorak', href: 'https://pivorak.com'
    expect(page).not_to have_link 'Login', href: '/users/sign_in'
    expect(page).not_to have_link 'Registration', href: '/users/sign_up'
  end

  scenario 'Navigation menu in unloggined user' do
    visit '/'

    expect(page).to have_link 'Pivorak', href: 'https://pivorak.com'
    expect(page).to have_link 'Login', href: '/users/sign_in'
    expect(page).to have_link 'Registration', href: '/users/sign_up'
    expect(page).not_to have_link 'Dashboard', href: '/app'
    expect(page).not_to have_link 'Accounts'
    expect(page).not_to have_link 'Records'
    expect(page).not_to have_link 'Categories'
    expect(page).not_to have_link 'Reports'
    expect(page).not_to have_link 'Logout', href: '/users/sign_out'
  end

  scenario 'User visit link "/app" without active session' do
    visit '/app'

    expect(current_path).to eql '/users/sign_in'
  end
end

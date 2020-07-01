# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/' do
  scenario 'success' do
    visit '/'

    # Please, use this for debug capybara specs
    # save_and_open_page

    expect(page).to have_content('Home')
  end
end

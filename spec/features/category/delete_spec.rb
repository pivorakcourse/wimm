# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category' do
  let!(:user) { assume_logged_user }
  let!(:category) { create(:category, user: user) }
  let!(:account) { create(:account, user: user) }
  let(:record) { create(:record, user: user, account: account, category: category) }

  before { visit categories_path }

  scenario 'if unused category' do
    click_link category.name
    expect(page).to have_link('Delete')
    expect do
      click_link 'Delete'
    end.to change { Category.count }.from(1).to(0)
  end

  scenario 'if used category' do
    record
    visit categories_path
    expect(page).to_not have_link('Delete')
  end
end

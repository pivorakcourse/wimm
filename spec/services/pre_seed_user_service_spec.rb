# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PreSeedUserService do
  let(:user) { create(:user) }

  subject { described_class.new(user) }

  it 'successfully create account' do
    expect do
      subject.call
    end.to change { Account.count }.from(0).to(2)

    expect(user.accounts.count).to eq 2
    expect(user.accounts).to include(
      have_attributes(name: 'Cash'),
      have_attributes(name: 'Credit Card')
    )
  end

  it 'successfully create category' do
    expect do
      subject.call
    end.to change { Category.count }.from(0).to(12)

    expect(user.categories.count).to eq 12
    expect(user.categories).to include(
      have_attributes(name: AccountTransferService::TRANSFER, type: 'ExpenseCategory'),
      have_attributes(name: 'Home', type: 'ExpenseCategory'),
      have_attributes(name: 'Food', type: 'ExpenseCategory'),
      have_attributes(name: 'Sport', type: 'ExpenseCategory'),
      have_attributes(name: 'Learning', type: 'ExpenseCategory'),
      have_attributes(name: 'Cloth', type: 'ExpenseCategory'),
      have_attributes(name: 'Car', type: 'ExpenseCategory'),
      have_attributes(name: 'Travel', type: 'ExpenseCategory'),
      have_attributes(name: 'Fun', type: 'ExpenseCategory'),
      have_attributes(name: AccountTransferService::TRANSFER, type: 'IncomeCategory'),
      have_attributes(name: 'Salary', type: 'IncomeCategory'),
      have_attributes(name: 'Other', type: 'IncomeCategory')
    )
  end
end

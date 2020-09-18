# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRecordService do
  let!(:user)       { create(:user) }
  let!(:account)    { create(:account, :with_money, user_id: user.id) }
  let!(:account2)   { create(:account, name: 'Mono', user_id: user.id) }
  let!(:category)   { create(:category, user_id: user.id) }
  let(:amount)      { { 'amount' => 200.0 } }
  let!(:record) do
    create(
      :record,
      category:   category,
      account:    account,
      user:       user,
      created_at: Date.today - 1.day
    )
  end

  let!(:income_transfer_category) do
    create(
      :category,
      :income_transfer_category,
      user_id: user.id
    )
  end

  let!(:expense_transfer_category) do
    create(
      :category,
      :expense_transfer_category,
      user_id: user.id
    )
  end

  let!(:transfer) do
    AccountTransferService.new(
      from:     account.id,
      to:       account2.id,
      transfer: 100,
      user:     user
    ).call
  end
  subject(:records) { user.records.where.not(id: record.id) }

  it 'successfully update transfer records' do
    described_class.new(subject.first, amount, user).call
    expect(subject.reload.first.amount).to eq(-amount['amount'])
    expect(subject.last.amount).to eq(amount['amount'])
  end

  it 'successfully update record' do
    described_class.new(user.records.first, amount, user).call
    expect(user.records.first.amount).to eq(amount['amount'])
  end
end

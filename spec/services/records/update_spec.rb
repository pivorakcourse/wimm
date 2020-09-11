# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRecordService do
  let!(:user)       { create(:user) }
  let!(:account)    { create(:account, :with_money, user_id: user.id) }
  let!(:account2)   { create(:account, name: 'Mono', user_id: user.id) }
  let!(:category)   { create(:category, user_id: user.id) }
  let(:amount)      { "200.0" }
  let!(:record) do
    create(
      :record,
      category:   category,
      account:    account,
      user:       user,
      created_at: Date.today
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

  it 'successfully update record' do
    # binding.pry
    described_class.new(user.records.last, amount, user).call
    expect(user.records.last.reload.amount).to eq(amount.to_f)
    expect(user.records.second_to_last.reload.amount).to eq(-amount.to_f)
    expect(user.balance).to_be eq(100.0)
  end

  # it 'do not update transfer records' do
    
  # end

  # it 'failure with errors' do

  # end
end

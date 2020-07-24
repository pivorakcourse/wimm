# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountTransferService do
  let!(:user)           { create(:user) }
  let!(:account)        { create(:account, user_id: user.id) }
  let!(:other_account)  { create(:account, name: 'Mono', user_id: user.id) }
  let!(:income_transfer_category) do
    create(
      :category,
      :income_transfer_category,
      user_id: user.id
    )
  end

  let!(:withdraw_transfer_category) do
    create(
      :category,
      :withdraw_transfer_category,
      user_id: user.id
    )
  end

  let(:transfer) { 100 }

  it 'successfully transfer money' do
    described_class.new(from: account.id, to: other_account.id, transfer: transfer, user: user).call

    expect(other_account.reload.balance).to eq(transfer)
    expect(account.reload.balance).to eq(-transfer)
  end

  it 'not change balance' do
    described_class.new(from: account, to: account, transfer: transfer, user: user).call

    expect(account.reload.balance).to eq(0)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRecordService do
  let!(:user)     { create(:user) }
  let!(:account)  { create(:account, :with_money, user_id: user.id) }
  let!(:account2) { create(:account, name: 'Mono', user_id: user.id) }
  let!(:category) { create(:category, user_id: user.id) }
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

  let!(:new_amount) { 200 }

  it 'successfully update record' do
    expect do
      described_class.call(user.records.last, record_params, current_user)
    end.to change { Account.count }.from(0).to(1)
    expect(created_account.name).to eq valid_params[:name]
  end

  it 'successfully update transfer records' do
    expect do
      described_class.call(valid_params, current_user)
    end.to change { Account.count }.from(0).to(1)
    expect(created_account.name).to eq valid_params[:name]
  end

  it 'failure with errors' do
    expect do
      described_class.call(invalid_params, current_user)
    end.not_to change { Account.count }

    expect(created_account).to eq nil
  end
end

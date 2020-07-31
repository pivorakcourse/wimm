# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransferRecordsQuery do
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

  subject(:query) { described_class.new(user, user.records.last).related_transfer_records }
  subject(:query2) { described_class.new(user, user.records.second_to_last).related_transfer_records }

  describe 'got expected query result' do
    it 'returns expected number of values' do
      expect(query.size).to eq(2)
      expect(query2.size).to eq(2)
    end

    it 'returns equal values' do
      expect(query).to include(query2[0])
      expect(query).to include(query2[1])
    end
  end
end

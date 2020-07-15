# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmountSumQuery do
  let!(:user)      { create(:user) }
  let!(:account)   { create(:account, user_id: user.id) }
  let!(:category)  { create(:category, user_id: user.id) }
  let!(:category2) { create(:category, user_id: user.id, name: 'bills') }
  let!(:record)    { create(:record, category_id: category.id, account_id: account.id, user_id: user.id) }
  let!(:record2)   { create(:record, category_id: category2.id, account_id: account.id, user_id: user.id, amount: 300) }
  let!(:record3)   { create(:record, category_id: category2.id, account_id: account.id, user_id: user.id) }
  let!(:record4) do
    create(
      :record,
      category_id: category2.id,
      account_id:  account.id,
      user_id:     user.id,
      created_at:  '01.01.20'
    )
  end

  subject(:query) { described_class.new(user).amount_sum_series }

  describe 'got expected sum' do
    it 'returns expected sum' do
      expect(query.size).to eq(2)
      expect(query[category.name]).to eq(record.amount)
    end

    it 'does not include old record' do
      expect(query[category2.name]).to eq(record2.amount + record3.amount)
    end
  end
end

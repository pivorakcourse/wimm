# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BalanceCalculateService do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let!(:account) { create(:account, user: user) }
  let!(:record) { create(:record, user: user, account: account, category: category) }

  it 'balance has changed' do
    expect do
      described_class.new(record).call
    end.to change { record.account.balance }.by(-record.amount)
  end
end

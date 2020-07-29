# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateTotalBalanceAccountService do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let!(:account) { create(:account, user: user) }
  let!(:record) { create(:record, user: user, account: account, category: category) }
  let!(:record_1) { create(:record, user: user, account: account, category: category, amount: 200) }
  let!(:record_2) { create(:record, user: user, account: account, category: category, amount: 700) }
  subject { described_class.new(record).call }

  it 'balance has changed' do
    sum_ammount = record.amount + record_1.amount + record_2.amount

    expect(subject).to eq(sum_ammount)
  end
end

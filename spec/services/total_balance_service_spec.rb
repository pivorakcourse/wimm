# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TotalBalanceService do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user: user, balance: 100) }
  let!(:account_2) { create(:account, user: user, balance: 200) }
  let!(:account_3) { create(:account, user: user, balance: -400) }
  subject { described_class.new(user).call }

  it 'balance has changed' do
    balance = account.balance + account_2.balance + account_3.balance
    expect(subject).to eq(balance)
  end
end

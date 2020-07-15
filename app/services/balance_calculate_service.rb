# frozen_string_literal: true

class BalanceCalculateService
  attr_reader :account, :amount, :balance

  def initialize(record)
    @account = record.account
    @amount = record.amount
    @balance = record.account.balance
  end

  def call
    account.update(balance: balance - amount)
  end
end

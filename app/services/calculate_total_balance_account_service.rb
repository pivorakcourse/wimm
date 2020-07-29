# frozen_string_literal: true

class CalculateTotalBalanceAccountService
  attr_reader :account, :amount, :balance

  def initialize(record)
    @account = record.account
  end

  def call
    Record.where(account: @account).sum(:amount)
  end
end

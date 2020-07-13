# frozen_string_literal: true

class RemoveAccountPolicy
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def allowed?
    account.records.count.zero?
  end
end

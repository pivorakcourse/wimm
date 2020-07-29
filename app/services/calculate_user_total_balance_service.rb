# frozen_string_literal: true

class CalculateUserTotalBalanceService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    user.accounts.sum(:balance)
  end
end

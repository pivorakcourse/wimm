# frozen_string_literal: true

class AccountTransferService
  TRANSFER = 'Transfer'

  def initialize(from:, to:, transfer:, user:)
    @from = from
    @to = to
    @transfer = transfer
    @user = user
  end

  def call
    ApplicationRecord.transaction do
      CreateRecordService.new(expense_params, user).call
      CreateRecordService.new(income_params, user).call
    end
  end

  private

  attr_reader :from, :to, :transfer, :user

  def income_params
    { amount: transfer, account_id: to, category_id: CategoryIdQuery.new(user).income }
  end

  def expense_params
    { amount: transfer, account_id: from, category_id: CategoryIdQuery.new(user).expense }
  end
end

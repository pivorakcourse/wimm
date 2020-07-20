# frozen_string_literal: true

class RecordCreateService
  WITHDRAW_CATEGORY = 'WithdrawCategory'
  INCOME_CATEGORY = 'IncomeCategory'

  attr_reader :params, :record

  def initialize(params, user)
    @params = params
    @record = user.records.build(params)
  end

  def call
    case record.category.type
    when WITHDRAW_CATEGORY
      withdraw
    when INCOME_CATEGORY
      income
    end
    record
  end

  private

  def withdraw
    record.update(amount: -record.amount)
  end

  def income
    record.update(amount: record.amount)
  end
end

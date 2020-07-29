# frozen_string_literal: true

class CreateRecordService
  EXPENSE_CATEGORY = 'ExpenseCategory'
  INCOME_CATEGORY = 'IncomeCategory'

  attr_reader :params, :record

  def initialize(params, user)
    @params = params
    @record = user.records.build(params)
  end

  def call
    case record.category.type
    when EXPENSE_CATEGORY
      expense
    when INCOME_CATEGORY
      income
    end
    record
  end

  private

  def expense
    record.update(amount: -record.amount)
  end

  def income
    record.update(amount: record.amount)
  end
end

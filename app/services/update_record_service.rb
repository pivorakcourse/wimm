class CreateRecordService

  attr_reader :params, :record

  def initialize(record, params, user)
    @params = params
    @record = user.records.build(params)
  end

  def call
    case record.category.type
    when CreateRecordService::EXPENSE_CATEGORY
      expense
    when CreateRecordService::INCOME_CATEGORY
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
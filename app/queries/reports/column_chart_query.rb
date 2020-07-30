# frozen_string_literal: true

module Reports
  class ColumnChartQuery
    attr_reader :user, :from, :to, :records, :months, :sum_amount

    def initialize(user, from, to)
      @from = from || Date.today.at_beginning_of_year
      @to = to
      @user = user
      @records = Record.joins(:category)
      @months = []
      @sum_amount = []
      @category = Category.all
    end

    def income_records
      filter_record
      @income_records ||= records.where("categories.type = 'IncomeCategory' AND categories.name != 'Transfer'")
                                 .group_by_month('created_at')
                                 .sum('amount')

      @income_records.each do |k, v|
        months.push(k.to_s)
        sum_amount.push(v)
      end
    end

    def expense_records
      filter_record
      @expense_records ||= records.where("categories.type = 'ExpenseCategory' AND categories.name != 'Transfer'")
                                  .group_by_month('created_at')
                                  .sum('amount')

      @expense_records.each do |k, v|
        months.push(k.to_s)
        sum_amount.push(-v)
      end
    end

    private

    def filter_record
      @records = records.where(user_id: user.id)
      @records = records.where('records.created_at >= ?', from) if from.present?
      @records = records.where('records.created_at <= ?', to) if to.present?
      @records
    end
  end
end

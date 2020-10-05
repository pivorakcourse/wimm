# frozen_string_literal: true

module Reports
  class MonthlySummariesController < BaseController
    def show
      @from = params[:from]
      @to = params[:to]
      @income_report = Reports::ColumnChartQuery.new(current_user, @from, @to)
      @income_report.income_records
      @expense_report = Reports::ColumnChartQuery.new(current_user, @from, @to)
      @expense_report.expense_records
    end
  end
end

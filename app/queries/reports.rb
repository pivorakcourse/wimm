# frozen_string_literal: true

module Reports
  class CategoryReportsQuery
    def initialize(user)
      @user = user
    end

    def period_sum(start_period, end_period)
      Record.where(user: user)
            .where('DATE(created_at) >= ? AND DATE(created_at) <= ?', start_period, end_period)
            .group('category')
            .sum('amount').each_with_object({}) { |(category, amount), acum| acum[category.name] = amount }
    end

    private

    attr_reader :user
  end
end

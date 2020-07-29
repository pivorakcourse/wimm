# frozen_string_literal: true

class AmountSumQuery
  include ExpenseAndTransfer

  def initialize(user)
    @user = user
  end

  def amount_sum_series
    Record.where(user_id: user.id)
          .where(['created_at > ?', 30.days.ago])
          .group('category')
          .sum('amount').each_with_object({}) do |(category, amount), acum|
      acum[category.name] = amount if transfer?(category) && expense?(category)
    end
  end

  private

  attr_reader :user
end

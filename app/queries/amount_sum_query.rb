# frozen_string_literal: true

class AmountSumQuery
  def initialize(user)
    @user = user
  end

  def amount_sum_series
    Record.where(user_id: user.id)
          .where(['created_at > ?', 30.days.ago])
          .group('category')
          .sum('amount').each_with_object({}) do |(k, v), hh|
      hh[k.name] = v if k.name != AccountTransferService::TRANSFER
    end
  end

  private

  attr_reader :user
end

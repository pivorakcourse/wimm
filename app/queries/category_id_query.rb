# frozen_string_literal: true

class CategoryIdQuery
  def initialize(user)
    @user = user
  end

  def expense
    ExpenseCategory.where(user_id: user.id).where(name: AccountTransferService::TRANSFER).ids[0]
  end

  def income
    IncomeCategory.where(user_id: user.id).where(name: AccountTransferService::TRANSFER).ids[0]
  end

  private

  attr_reader :user
end

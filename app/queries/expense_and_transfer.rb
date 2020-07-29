# frozen_string_literal: true

module ExpenseAndTransfer
  def transfer?(category)
    (category.name != AccountTransferService::TRANSFER)
  end

  def expense?(category)
    category.type != CreateRecordService::INCOME_CATEGORY
  end
end

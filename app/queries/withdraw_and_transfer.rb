# frozen_string_literal: true

module WithdrawAndTransfer
  def transfer?(category)
    (category.name != AccountTransferService::TRANSFER)
  end

  def withdraw?(category)
    category.type != CreateRecordService::INCOME_CATEGORY
  end
end

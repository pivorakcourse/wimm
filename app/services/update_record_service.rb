# frozen_string_literal: true

class UpdateRecordService
  attr_reader :new_amount, :record, :user

  def initialize(record, new_amount, user)
    @new_amount = new_amount['amount'].to_f
    @record = record
    @user = user
  end

  def call
    if transfer?
      transfer_update
    else
      simple_update
    end
  end

  private

  def transfer_update
    records = TransferRecordsQuery.new(user, record).related_transfer_records
    ApplicationRecord.transaction do
      records.where('amount > 0').update_all(amount: new_amount)
      records.where('amount < 0').update_all(amount: -new_amount)
    end
  end

  def simple_update
    record.update(amount: new_amount)
  end

  def transfer?
    record.category.name == AccountTransferService::TRANSFER
  end
end

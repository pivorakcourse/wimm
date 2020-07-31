# frozen_string_literal: true

class DestroyRecordService
  attr_reader :record, :user

  def initialize(record, user)
    @record = record
    @user = user
  end

  def call
    record.destroy unless transfer?

    TransferRecordsQuery.new(user, record).related_transfer_records.delete_all
  end

  private

  def transfer?
    record.category.name == AccountTransferService::TRANSFER
  end
end

class UpdateRecordService

  attr_reader :params, :record

  def initialize(record, record_params, user)
    @record_params = record_params
    @record = record
    @user = user
  end

  def call
    record_category_type = record.category.type
    record.update(record_params) if transfer?(record_category_type)

    records = TransferRecordsQuery.new(user, record).related_transfer_records
    binding.pry
    records.each_with_object do |record|
      if record.category.type == CreateRecordService::EXPENSE_CATEGORY
        record.update!(record_params[amount: -new_amount])
      else
        record.update!(record_params[amount: new_amount])
      end
    end
  end

  private

  def transfer?(type)
    record_category_type == AccountTransferService::TRANSFER
  end
end
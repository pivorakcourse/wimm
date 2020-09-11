class UpdateRecordService

  attr_reader :new_amount, :record, :user

  def initialize(record, new_amount, user)
    # binding.pry
    @new_amount = new_amount
    @record = record
    @user = user
  end

  def call
    unless transfer?(record.category.name)
      record.update!({'amount' => new_amount})
    else
      records = TransferRecordsQuery.new(user, record).related_transfer_records
      first_record = records[0]
      second_record = records[1]
      binding.pry
      case first_record.category.type
      when CreateRecordService::EXPENSE_CATEGORY
        ApplicationRecord.transaction do
          first_record.update!({'amount' => "-#{new_amount}"})
          second_record.update!({'amount' => new_amount})
         end
      when CreateRecordService::INCOME_CATEGORY
        ApplicationRecord.transaction do
          first_record.update!({'amount' => new_amount})
          second_record.update!({'amount' => "-#{new_amount}"})
        end
      end
    end
  end

  private

  def transfer?(type)
    record.category.name == AccountTransferService::TRANSFER
  end
end
# frozen_string_literal: true

class TransferRecordsQuery
  def initialize(user, record)
    @user = user
    @record = record
  end

  def related_transfer_records
    Record.where(user: user)
          .where('extract(epoch from "created_at")::integer = ?', record.created_at.to_f.round)
          .where('("amount" = -(?)) OR ("amount" = (?))', record.amount, record.amount)
  end

  private

  attr_reader :user, :record
end

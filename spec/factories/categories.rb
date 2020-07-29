# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Food' }
    icon { '' }
  end

  trait :income_category do
    name { 'Salary' }
    type { CreateRecordService::INCOME_CATEGORY }
  end

  trait :income_transfer_category do
    name { AccountTransferService::TRANSFER }
    type { CreateRecordService::INCOME_CATEGORY }
  end

  trait :expense_transfer_category do
    name { AccountTransferService::TRANSFER }
    type { CreateRecordService::EXPENSE_CATEGORY }
  end
end

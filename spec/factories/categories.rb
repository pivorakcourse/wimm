# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Food' }
    icon { '' }
  end

  trait :income_category do
    name { 'Salary' }
    type { RecordCreateService::INCOME_CATEGORY }
  end

  trait :income_transfer_category do
    name { AccountTransferService::TRANSFER }
    type { RecordCreateService::INCOME_CATEGORY }
  end

  trait :withdraw_transfer_category do
    name { AccountTransferService::TRANSFER }
    type { RecordCreateService::WITHDRAW_CATEGORY }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Food' }
    icon { '' }
  end
  factory :income_category do
    name { 'Salary' }
    icon { '' }
    type { 'IncomeCategory' }
  end
end

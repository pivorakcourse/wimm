# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    amount { 100 }
    account_id { 1 }
    category_id { 1 }
  end
end

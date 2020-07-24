# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { 'Cash' }
    balance { 0 }
  end

  trait :with_money do
    balance { 1000 }
  end
end

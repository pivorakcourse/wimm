# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email     { 'john1@example.com' }
    password  { 'sEcReT321' }
  end
end

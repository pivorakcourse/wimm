# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category

  validates :amount, presence: true, numericality: { other_than: 0 }
end

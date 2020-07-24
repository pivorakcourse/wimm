# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :records

  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }

  scope :exclude_transfer, -> { where.not(name: AccountTransferService::TRANSFER) }
end

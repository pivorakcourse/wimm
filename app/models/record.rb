# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category

  validates :amount, presence: true, numericality: { other_than: 0 }

  after_save    :balance_update
  after_destroy :balance_update

  private

  def balance_update
    account.update(balance: CalculateTotalBalanceAccountService.new(self).call)
  end
end

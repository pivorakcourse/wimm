# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  helper_method :accounts, :record, :records, :total_balance, :income_categories, :withdraw_categories

  private

  def accounts
    @accounts ||= current_user.accounts
  end

  def record
    @record ||= current_user.records.build
  end

  def records
    @records ||= current_user.records.includes(:account, :category)
  end

  def total_balance
    @total_balance ||= TotalBalanceService.new(current_user).call
  end

  def income_categories
    @income_categories ||= IncomeCategory.where(user: current_user)
  end

  def withdraw_categories
    @withdraw_categories ||= WithdrawCategory.where(user: current_user)
  end
end

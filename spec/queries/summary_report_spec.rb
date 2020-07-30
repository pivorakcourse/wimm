# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::ColumnChartQuery do
  let!(:user)               { create(:user) }
  let!(:account)            { create(:account, user_id: user.id) }
  let!(:income_category)    { create(:category, user_id: user.id, type: 'IncomeCategory') }
  let!(:expense_category)   { create(:category, user_id: user.id, type: 'ExpenseCategory') }
  let!(:transfer_category)  { create(:category, user_id: user.id, type: 'ExpenseCategory', name: 'Transfer') }
  let!(:record_this_month) do
    create(
      :record,
      category:   income_category,
      account:    account,
      user:       user,
      created_at: Date.today
    )
  end

  let!(:transfer_record_previous_month) do
    create(
      :record,
      category:   transfer_category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_month.last_month
    )
  end

  let!(:record_previous_month) do
    create(
      :record,
      category:   expense_category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_month.last_month
    )
  end

  let!(:record_this_year) do
    create(
      :record,
      category:   income_category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_year
    )
  end

  let!(:record_previous_year) do
    create(
      :record,
      category:   expense_category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_year.last_year
    )
  end

  subject(:query_income_this_month) do
    described_class.new(user, Date.today.at_beginning_of_month, Date.today)
  end

  subject(:query_income_this_year) do
    described_class.new(user, Date.today.at_beginning_of_year, Date.today.at_end_of_year)
  end

  subject(:query_expense_all_time) do
    described_class.new(user, Date.today.at_beginning_of_year.last_year, Date.today)
  end

  describe 'got expected sum' do
    it 'returns expected sum of income records this month' do
      query_income_this_month.income_records
      income_category_records_array = query_income_this_month.sum_amount

      expect(income_category_records_array.sum).to eq(record_this_month.amount)
    end

    it 'returns expected sum of income records this year' do
      query_income_this_year.income_records
      income_category_records_array = query_income_this_year.sum_amount

      expect(income_category_records_array.sum).to eq(record_this_month.amount + record_this_year.amount)
    end

    it 'returns expected sum of expense records all time' do
      query_expense_all_time.expense_records
      income_category_records_array = query_expense_all_time.sum_amount

      expect(income_category_records_array.sum).to eq(-record_previous_month.amount - record_previous_year.amount)
    end
  end
end

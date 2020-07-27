# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::CategoryReportsQuery do
  let!(:user)      { create(:user) }
  let!(:account)   { create(:account, user_id: user.id) }
  let!(:category)  { create(:category, user_id: user.id) }
  let!(:record_this_month) do
    create(
      :record,
      category:   category,
      account:    account,
      user:       user,
      created_at: Date.today
    )
  end

  let!(:record_previous_month) do
    create(
      :record,
      category:   category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_month.last_month
    )
  end

  let!(:record_this_year) do
    create(
      :record,
      category:   category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_year
    )
  end

  let!(:record_previous_year) do
    create(
      :record,
      category:   category,
      account:    account,
      user:       user,
      created_at: Date.today.at_beginning_of_year.last_year
    )
  end

  subject(:query_this_month) do
    described_class.new(user)
                   .period_sum(Date.today.at_beginning_of_month, Date.today)
  end

  subject(:query_previous_month) do
    described_class.new(user)
                   .period_sum(Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month)
  end

  subject(:query_this_year) do
    described_class.new(user)
                   .period_sum(Date.today.at_beginning_of_year, Date.today.at_end_of_year)
  end

  subject(:query_previous_year) do
    described_class.new(user)
                   .period_sum(Date.today.at_beginning_of_year.last_year, Date.today.at_end_of_year.last_year)
  end

  describe 'got expected sum' do
    it 'returns expected sum of this month' do
      expect(query_this_month.size).to eq(1)
      expect(query_this_month[category.name]).to eq(record_this_month.amount)
    end

    it 'returns expected sum previous month' do
      expect(query_previous_month.size).to eq(1)
      expect(query_previous_month[category.name]).to eq(record_previous_month.amount)
    end

    it 'returns expected sum of this year' do
      expect(query_this_year.size).to eq(1)
      expect(query_this_year[category.name])
        .to eq(record_this_year.amount + record_previous_month.amount + record_this_month.amount)
    end

    it 'returns expected sum of previous year' do
      expect(query_previous_year.size).to eq(1)
      expect(query_previous_year[category.name]).to eq(record_previous_year.amount)
    end
  end
end

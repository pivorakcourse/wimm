# frozen_string_literal: true

module Reports
  class CategoriesSummariesController < ApplicationController
    before_action :authenticate_user!

    helper_method :start_period, :end_period

    private

    def start_period
      @start_period ||= params.fetch(:from, Date.today.at_beginning_of_month).to_date
    end

    def end_period
      @end_period ||= params.fetch(:to, Date.today).to_date
    end
  end
end

# frozen_string_literal: true

module ReportsHelper
  THIS_MONTH     = 'this month'
  PREVIOUS_MONTH = 'previous month'
  THIS_YEAR      = 'this year'
  PREVIOUS_YEAR  = 'previous year'

  def this_month_link
    link_to THIS_MONTH,
            reports_category_reports_path(
              from: Date.today.at_beginning_of_month,
              to:   Date.today
            )
  end

  def previous_month_link
    link_to PREVIOUS_MONTH,
            reports_category_reports_path(
              from: Date.today.at_beginning_of_month.last_month,
              to:   Date.today.at_end_of_month.last_month
            )
  end

  def this_year_link
    link_to THIS_YEAR,
            reports_category_reports_path(
              from: Date.today.at_beginning_of_year,
              to:   Date.today.at_end_of_year
            )
  end

  def previous_year_link
    link_to PREVIOUS_YEAR,
            reports_category_reports_path(
              from: Date.today.at_beginning_of_year.last_year,
              to:   Date.today.at_end_of_year.last_year
            )
  end
end

# frozen_string_literal: true

module ReportsHelper
  THIS_MONTH     = 'this month'
  PREVIOUS_MONTH = 'previous month'
  THIS_YEAR      = 'this year'
  PREVIOUS_YEAR  = 'previous year'

  def this_month_link(method)
    link_to THIS_MONTH,
            public_send(
              method,
              from: Date.today.at_beginning_of_month,
              to:   Date.today
            )
  end

  def previous_month_link(method)
    link_to PREVIOUS_MONTH,
            public_send(
              method,
              from: Date.today.at_beginning_of_month.last_month,
              to:   Date.today.at_end_of_month.last_month
            )
  end

  def this_year_link(method)
    link_to THIS_YEAR,
            public_send(
              method,
              from: Date.today.at_beginning_of_year,
              to:   Date.today.at_end_of_year
            )
  end

  def previous_year_link(method)
    link_to PREVIOUS_YEAR,
            public_send(
              method,
              from: Date.today.at_beginning_of_year.last_year,
              to:   Date.today.at_end_of_year.last_year
            )
  end
end

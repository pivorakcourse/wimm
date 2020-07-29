# frozen_string_literal: true

module Reports
  class ReportsController < ApplicationController
    before_action :authenticate_user!
  end
end

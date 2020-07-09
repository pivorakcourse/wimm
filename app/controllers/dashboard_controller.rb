# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @record = current_user.records.build
    @accounts = current_user.accounts
    @categories = current_user.categories
  end
end

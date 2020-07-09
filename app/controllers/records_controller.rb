# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @records = current_user.records.includes(:account, :category)
  end

  def create
    @record = current_user.records.build(record_params)

    if @record.save
      redirect_to app_dashboard_path, notice: 'Record was successfully created.'
    else
      redirect_to app_dashboard_path, notice: 'Record can`t be blank and record can`t be zero'
    end
  end

  private

  def record_params
    params.require(:record).permit(:amount, :account_id, :category_id)
  end
end

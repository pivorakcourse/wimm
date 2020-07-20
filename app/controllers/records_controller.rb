# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @records = current_user.records.includes(:account, :category)
  end

  def create
    @record = RecordCreateService.new(record_params, current_user).call

    if @record.persisted?
      redirect_to user_root_path, notice: 'Record was successfully created.'
    else
      redirect_to user_root_path, notice: 'Record can`t be string and record can`t be zero'
    end
  end

  private

  def record_params
    params.require(:record).permit(:amount, :account_id, :category_id)
  end
end

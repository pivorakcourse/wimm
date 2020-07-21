# frozen_string_literal: true

class RecordsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @records = pagy(current_user.records.includes(:account, :category))
  end

  def create
    @record = RecordCreateService.new(record_params, current_user).call

    if @record.persisted?
      redirect_to user_root_path, notice: 'Record was successfully created.'
    else
      redirect_to user_root_path, notice: 'Record can`t be string and record can`t be zero'
    end
  end

  def edit
    @accounts = current_user.accounts
    @categories = current_user.categories
    @record = current_user.records.find(params[:id])
  end

  def update
    @record = current_user.records.find(params[:id])

    if @record.update(record_params)
      redirect_to records_path, notice: 'Record has been updated'
    else
      redirect_to edit_record_path, notice: 'Record can`t be string and record can`t be zero'
    end
  end

  def destroy
    @record = current_user.records.find(params[:id])
    redirect_to records_path, notice: 'Record has been deleted' if @record.destroy
  end

  private

  def record_params
    params.require(:record).permit(:amount, :account_id, :category_id)
  end
end

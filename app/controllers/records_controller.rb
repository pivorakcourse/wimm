# frozen_string_literal: true

class RecordsController < BaseController
  include Pagy::Backend

  def index
    @pagy, @records = pagy(current_user.records.includes(:account, :category))
  end

  def create
    @record = CreateRecordService.new(record_params, current_user).call

    if @record.persisted?
      redirect_to redirect_rule, notice: 'Record was successfully created.'
    else
      redirect_to user_root_path(tab: 'expense'), notice: 'Record can`t be string and record can`t be zero'
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

    DestroyRecordService.new(@record, current_user).call

    redirect_to records_path, notice: 'Record has been deleted'
  end

  private

  def record_params
    params.require(:record).permit(:amount, :account_id, :category_id)
  end

  def redirect_rule
    if @record.category.type == CreateRecordService::INCOME_CATEGORY
      user_root_path(tab: 'income')
    else
      user_root_path(tab: 'expense')
    end
  end
end

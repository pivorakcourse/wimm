# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = Account.where(user_id: current_user.id)
  end

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = Account::Create.call(account_params, current_user)

    if @account.persisted?
      redirect_to accounts_path, notice: 'Account has been created'
    else
      flash.now[:error] = 'Account not created'
      render :new
    end
  end

  def edit
    @account = current_user.accounts.find(params[:id])
  end

  def update
    @account = current_user.accounts.find(params[:id])

    if @account.update(account_params)
      redirect_to accounts_path, notice: 'Account has been updated'
    else
      flash.now[:error] = 'Account not updated'
      render :new
    end
  end

  def destroy
    @account = current_user.accounts.find(params[:id])

    return unless RemoveAccountPolicy.new(@account).allowed?

    @account.destroy
    redirect_to accounts_path, notice: 'Account has been deleted'
  end

  private

  def account_params
    params.require(:account).permit(:name, :balance)
  end
end

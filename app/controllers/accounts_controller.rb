# frozen_string_literal: true

class AccountsController < ApplicationController
  def index
    @accounts = current_user.accounts
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

  private

  def account_params
    params.require(:account).permit(:name, :balance)
  end
end

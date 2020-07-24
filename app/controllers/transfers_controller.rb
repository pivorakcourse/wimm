# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action :authenticate_user!

  def create
    AccountTransferService.new(
      from:     transfer_params[:from_account_id],
      to:       transfer_params[:to_account_id],
      transfer: transfer_params[:transfer],
      user:     current_user
    ).call

    redirect_to user_root_path(tab: 'transfer')
  end

  private

  def transfer_params
    params.require(:transfers).permit(:from_account_id, :to_account_id, :transfer)
          .to_h
          .symbolize_keys
  end
end

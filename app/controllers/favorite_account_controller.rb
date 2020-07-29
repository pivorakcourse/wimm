# frozen_string_literal: true

class FavoriteAccountController < ApplicationController
  def update
    current_user.update(favorite_account_id: params[:account_id])
    redirect_to accounts_path
  end
end

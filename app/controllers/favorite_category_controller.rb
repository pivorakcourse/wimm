# frozen_string_literal: true

class FavoriteCategoryController < ApplicationController
  def update
    current_user.update(favorite_category_id: params[:category_id])
    redirect_to categories_path
  end
end

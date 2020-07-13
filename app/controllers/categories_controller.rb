# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.where(user_id: current_user.id)
  end

  def new
    @category = current_user.categories.build
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    @category = current_user.categories.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])

    if RemoveCategoryPolicy.new(@category).allowed?
      @category.destroy
      redirect_to categories_path, notice: 'Category has been deleted'
    else
      redirect_to categories_path, notice: 'Category not deleted'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

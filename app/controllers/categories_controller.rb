# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.where(user: current_user)
    @withdraw_categories = WithdrawCategory.where(user: current_user)
    @income_categories = IncomeCategory.where(user: current_user)
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
      redirect_to categories_path, notice: 'Category has been created'
    else
      flash.now[:error] = 'Category not created'
      render :new
    end
  end

  def update
    @category = current_user.categories.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category has been updated'
    else
      flash.now[:error] = 'Category not updated'
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
    params.require(:category).permit(:name, :type)
  end
end

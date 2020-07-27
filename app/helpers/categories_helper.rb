# frozen_string_literal: true

module CategoriesHelper
  def delete_category_button(category)
    return unless RemoveCategoryPolicy.new(category).allowed?

    link_to 'Delete', category_path(category), id: category.id, method: :delete,
    class: 'button button secondary', data: { confirm: 'Are you sure?' }
  end

  def maybe_make_favorite_category_link(category)
    return if category.type == IncomeCategory.name

    link_to 'Make it favorite',
            category_favorite_path(@category),
            method: :put,
            class:  'button'
  end

  FAVORITE_TAG = '(Favorite)'

  def maybe_favorite_category_tag(category)
    return unless category.id == current_user.favorite_category_id

    content_tag :span, FAVORITE_TAG
  end
end

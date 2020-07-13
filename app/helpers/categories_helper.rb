# frozen_string_literal: true

module CategoriesHelper
  def delete_category_button(category)
    return unless RemoveCategoryPolicy.new(category).allowed?

    link_to 'Delete', category_path(category), id: category.id, method: :delete,
    class: 'button button secondary', data: { confirm: 'Are you sure?' }
  end
end

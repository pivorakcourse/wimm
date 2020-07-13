# frozen_string_literal: true

class RemoveCategoryPolicy
  attr_reader :category

  def initialize(category)
    @category = category
  end

  def allowed?
    category.records.count.zero?
  end
end

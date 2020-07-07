# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
end

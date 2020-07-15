# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user

  has_many :records

  validates :name, length: { in: 2..15 }, presence: true
  validates :balance, numericality: true, format: { with: /\A\-?\d+(?:\.\d{0,2})?\z/ }, presence: true
end

# frozen_string_literal: true

class User < ApplicationRecord
  has_many :accounts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :categories

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

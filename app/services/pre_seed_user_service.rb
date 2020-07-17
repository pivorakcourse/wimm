# frozen_string_literal: true

class PreSeedUserService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    ApplicationRecord.transaction do
      user.accounts.create(default_accounts)
      user.categories.create(default_categories)
    end
  end

  private

  def default_accounts
    [
      {
        name: 'Cash'
      },
      {
        name: 'Credit Card'
      }
    ]
  end

  def default_categories
    [
      { name: 'Home' },
      { name: 'Food' },
      { name: 'Sport' },
      { name: 'Learning' },
      { name: 'Cloth' },
      { name: 'Car' },
      { name: 'Travel' },
      { name: 'Fun' }
    ]
  end
end

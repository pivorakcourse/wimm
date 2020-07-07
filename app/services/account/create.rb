# frozen_string_literal: true

class Account
  class Create
    def self.call(params, user)
      new(params, user).call
    end

    attr_reader :params, :user

    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      account = user.accounts.create(params)
      account.save
      account
    end
  end
end

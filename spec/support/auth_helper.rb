# frozen_string_literal: true

module AuthHelper
  def assume_logged_user(user = nil)
    user ||= user || User.create(email: 'example@example.com', password: 'sEcReT321')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user
  end
end

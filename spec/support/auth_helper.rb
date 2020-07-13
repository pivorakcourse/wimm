# frozen_string_literal: true

module AuthHelper
  def assume_logged_user(user = nil)
    user ||= User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    login_as(user, scope: :user)
    user
  end
end

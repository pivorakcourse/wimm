# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  prepend_after_action :pre_seed_user_service, only: :create

  protected

  def pre_seed_user_service
    return unless resource.persisted?

    PreSeedUserService.new(resource).call
  end
end

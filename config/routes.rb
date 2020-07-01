# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  scope 'app' do
    get '/', to: 'dashboard#index'
  end
end

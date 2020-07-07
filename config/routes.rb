# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :categories, except: %i[show destroy]

  scope 'app' do
    get '/', to: 'dashboard#index', as: 'app_dashboard'
    resources :accounts
  end
end

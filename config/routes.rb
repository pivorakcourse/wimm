# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  scope 'app' do
    get '/', to: 'dashboard#index', as: 'app_dashboard'
    resources :categories, except: %i[show destroy]
    resources :accounts
    resources :records
  end
end

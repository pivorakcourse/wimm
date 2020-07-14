# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  scope 'app' do
    get '/', to: 'dashboard#index', as: 'user_root'
    resources :categories, except: %i[show]
    resources :accounts
    resources :records
  end
end

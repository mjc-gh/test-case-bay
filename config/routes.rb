Rails.application.routes.draw do
  root 'contents#root'

  devise_for :users

  resources :projects do
    resources :steps, only: %i[create destroy]

    resources :suites, except: %i[index] do
      resources :cases, except: %i[index] do
        resources :steps, only: %i[index create], controller: 'case_steps'
      end
    end
  end

  resources :cases, only: [] do
    resources :steps, only: %i[index create edit update], controller: 'case_steps'
  end
end

Rails.application.routes.draw do
  resources :steps
  root 'contents#root'

  devise_for :users

  resources :projects do
    resources :steps, only: %i[create destroy]

    resources :suites do
      resources :cases, except: %i[index]
    end
  end
end

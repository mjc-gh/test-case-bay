Rails.application.routes.draw do
  root 'contents#root'

  devise_for :users

  resources :projects do
    resources :steps, only: %i[create destroy]

    resources :suites, except: %i[index] do
      resources :cases, except: %i[index]
    end
  end
end

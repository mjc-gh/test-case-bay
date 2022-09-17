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
    resources :steps, only: %i[index create destroy], controller: 'case_steps' do
      collection do
        get 'builder', as: :builder

        # Two-step form
        post 'add_new' => :add_new, as: :add_new
      end
    end
  end
end

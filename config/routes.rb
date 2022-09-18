Rails.application.routes.draw do
  root 'contents#root'

  devise_for :users

  resources :projects do
    resources :steps, only: %i[create destroy]

    resources :suites, except: %i[index] do
      resources :cases, except: %i[index]
    end
  end

  resources :cases, only: [] do
    resources :steps, only: %i[index create destroy], controller: 'case_steps' do
      collection do
        get 'builder', as: :builder

        # Two-step form
        post 'add_new' => :add_new, as: :add_new
      end

      member do
        post :append
        patch :reorder
      end
    end
  end

  resources :runs do
    resources :cases, only: %i[index destroy], controller: 'case_runs' do
      member do
        post :append
        patch :reorder
      end
    end

    resources :assignments, only: %i[new create show]
  end

  # Public assignment resource using the token as the :id
  resources :assignments, only: :show do
    resources :cases, only: [] do
      resources :steps, only: %i[index edit update], controller: 'assignment_case_steps'
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end

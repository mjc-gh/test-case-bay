Rails.application.routes.draw do
  devise_for :users
  root 'contents#root'
end

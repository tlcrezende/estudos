Rails.application.routes.draw do
  resources :videos
  root 'videos#index'

  resources :chats, only: [:index, :create, :show, :update]
  resources :resumes, only: :show
end

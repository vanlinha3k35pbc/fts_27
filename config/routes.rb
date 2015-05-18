Rails.application.routes.draw do
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  devise_for :users
  resources :users, only: :show
  resources :exams, only: [:index, :create]

  authenticate :user do
    root to: "exams#index", as: "authenticate_root"
  end

  namespace :admin do
    root 'dashboards#index'
    resources :users, only: [:index, :destroy]

    resources :categories do
      resources :questions, except: :index
    end
  end
end

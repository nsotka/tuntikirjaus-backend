Rails.application.routes.draw do
  # devise_for :users
  # devise_scope :user do
  #   post 'sign_up', to: "registrations#create"
  #   post 'sign_in', to: "sessions#create"
  # end
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'

devise_for :users
  devise_scope :user do
         post 'api/v1/sign_up', to: "api/v1/registrations#create"
         post 'api/v1/sign_in', to: "api/v1/sessions#create"
        
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :projects do
        resources :tasks
      end
      resources :users do
        resources :tasks do
          resources :user_tasks
        end
      end
      mount ActionCable.server => '/cable'
    end
  end
end

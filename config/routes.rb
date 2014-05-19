Tales::Application.routes.draw do
  localized do
    devise_for :users, controllers: {
      confirmations: "users/confirmations",
      omniauth_callbacks: "users/omniauth_callbacks", 
      passwords: "users/passwords",
      registrations: "users/registrations", 
      sessions: "users/sessions"
    }
    resources :users, only: :show
    
    resources :games, except: :index do
      resources :marks, only: [:create, :update]
      get "publish", to: "games#publish", on: :member
      resources :paragraphs do
        get "set_as_first", to: "paragraphs#set_as_first", on: :member
        resources :choices, except: [:index, :show]
      end
    end
    
    root to: "home#index"
  end
end

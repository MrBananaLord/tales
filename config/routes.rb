Tales::Application.routes.draw do
  localized do
    devise_for :users
    resources :users, only: :show
    
    resources :games, except: :index do
      resources :paragraphs do
        get "set_as_first", to: "paragraphs#set_as_first", on: :member
        resources :choices, except: [:index, :show]
      end
    end
    
    root to: "home#index"
  end
end

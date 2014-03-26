Tales::Application.routes.draw do
  localized do
    devise_for :users
    resources :users, only: :show
    
    resources :games, except: :index do
      resources :nodes do
        get "set_as_first", to: "nodes#set_as_first", on: :member
        resources :edges, except: [:index, :show]
      end
    end
    
    root to: "home#index"
  end
end

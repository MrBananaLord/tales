Tales::Application.routes.draw do
  localized do
    devise_for :users
    resources :users, only: :show
    
    resources :games, except: :index do
      resources :nodes, except: :index
    end
    
    root to: "home#index"
  end
end

Tales::Application.routes.draw do
  localized do
    devise_for :users
    resources :users, only: :show
    
    resources :games, except: :index do
      resources :nodes do
        resources :edges, except: :index
      end
    end
    
    root to: "home#index"
  end
end

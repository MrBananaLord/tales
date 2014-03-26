Tales::Application.routes.draw do
  localized do
    devise_for :users
    resources :users, only: :show
    
    resources :games
    
    root to: "home#index"
  end
end

Tales::Application.routes.draw do
  localized do
    devise_for :users
    resources :users, only: :show
    
    root to: "home#index"
  end
end

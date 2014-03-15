Tales::Application.routes.draw do
  localized do
    devise_for :users
    root to: "home#index"
  end
end

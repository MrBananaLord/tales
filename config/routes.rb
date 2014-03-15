Tales::Application.routes.draw do
  localized do
    root to: "home#index"
  end
end

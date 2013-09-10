Pasta::Application.routes.draw do
  resources :pantries
  root to: "pantries#index"
end

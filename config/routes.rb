Rails.application.routes.draw do
  resources :items
  get "/users/:user_id/items", to: "users#item_index"
  get "/users/:user_id/items/:id", to: "users#item_show"
  post "/users/:user_id/items", to: "users#item_create"
  resources :users
end

Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb,
  :anchor => false, via: [:get, :post]

  root to: "home#index"

  devise_for :users

  get "/about" => "about#index", as: :about

  get "/entries" => "entries#index"
  get "/entries/new" => "entries#new", as: :new_entry
  post "/entries" => "entries#create"
  get "/entries/:id" => "entries#show", as: :entry
  get "/entries/:id/edit" => "entries#edit", as: :edit_entry
  patch "/entries/:id" => "entries#update"
  delete "/entries/:id" => "entries#destroy"


  get "/comments" => "comments#index"
  get "/comments/new" => "comments#new", as: :new_comment
  post "/comments" => "comments#create"
  get "/comments/:id" => "comments#show", as: :comment
  get "/comments/:id/edit" => "comments#edit", as: :edit_comment
  patch "/comments/:id" => "comments#update"
  delete "/comments/:id" => "comments#destroy"


  resources :entries do
    resources :comments
    resources :favorites, only: [:create, :destroy]
  end
  resources :tags, only: [:new]
  resources :favorites, only: [:index]


end

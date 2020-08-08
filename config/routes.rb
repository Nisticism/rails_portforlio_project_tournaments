Rails.application.routes.draw do
  resources :games do
    resources :tournaments, only: [:index, :show, :new, :edit, :destroy]
  end
  resources :tournaments do
    resources :players, only: [:index, :show]
  end
  resources :players do
    resources :tournaments, only: [:index, :show]
    resources :games, only: [:index, :show]
  end

  resource :sessions, only: [:new, :create, :destroy]
  get 'logout' => 'sessions#destroy'

  root to: "tournaments#index"

  match '/auth/:provider', to: 'sessions#create_omni', via: [:get, :post]

  resource :sessions, only: [:new, :create, :destroy]

end

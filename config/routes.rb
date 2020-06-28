Rails.application.routes.draw do
  resources :games do 
    resources :tournaments, only: [:index, :show, :new, :edit]
  end
  resources :matches
  resources :tournaments
  resources :players, only: [:index, :show, :new, :create, :update, :delete]

  root to: "tournaments#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :players, only: [:index, :show, :new, :create, :update, :delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

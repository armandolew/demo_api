Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks, only: [:create, :show, :index, :update, :destroy]

  get "*any", via: :all, to: "application#not_found"
end

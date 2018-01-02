Rails.application.routes.draw do
  jsonapi_resources :tasks do
    jsonapi_relationships
    jsonapi_resources :task_labels
    jsonapi_resources :labels
    member do
      post :move
    end
  end
  jsonapi_resources :labels
  resource :registrations, only: [:sign_in, :sign_up, :confirmation] do
    collection do
      post :sign_up
      get :sign_in
      post :confirmation
    end
  end
  get "*any", via: :all, to: "application#not_found"
end

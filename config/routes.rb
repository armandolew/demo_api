Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  jsonapi_resources :tasks, only: [:create, :show, :index, :update, :destroy] do
    collection do
      get 'search'
    end
  end


  resource :registrations, only: [:sign_in, :sign_up, :confirmation] do
    collection do
      post '/sign_up', to: 'registrations#sign_up', as: 'sign_up'
      get  '/sign_in', to: 'registrations#sign_in', as: 'sign_in'
      get  '/confirmation/:token', to: 'registrations#confirmation', as: 'confirmation'
    end
  end

=begin
  jsonapi_resource :users do
    post 'registrations/sign_up', to: 'registrations#sign_up', as: 'sign_up'
    get 'registrations/sign_in', to: 'registrations#sign_in', as: 'sign_in'
    get 'registrations/confirmation/:token', to: 'registrations#confirmation', as: 'registration_confirmation'
  end
=end



  # Registrations, 
  # Users con confirmación (boolean)
  # data: {
  #   type: {} 
  # }
  # Respetar el spec. End points normalizados.
  # Contexto para resources.
  # No se puede utilizar la gema act as list.
  # concern.
  # relaciones dentro del spec.
  # busqueda con spec.
  # confirmacion de correo para login.
  # * imagen con base64.
  # compartir tareas, enviar por correo con la tarea dentro del correo.

  get "*any", via: :all, to: "application#not_found"
end
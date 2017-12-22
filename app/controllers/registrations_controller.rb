class RegistrationsController < ApplicationController
  def sign_up
    user = User.create(email: params[:email], password: params[:password])

    if user.persisted?
      render json: render_element_json(user, UserResource)
    else
      render json: "Error saving task".to_json
    end
  end

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) 
      render json: render_element_json(user, UserResource)
    else
      render json: "Not found".to_json
    end
  end
end
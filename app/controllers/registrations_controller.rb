class RegistrationsController < ApplicationController

  def sign_up
    user = User.create(email: params[:data][:attributes][:email], password: params[:data][:attributes][:password])

    if user.valid?
      #UserNotificationsMailer.sign_up_mailer(user).deliver
      render json: render_element_json(user, UserResource)
    else
      render json: "#{user.errors}".to_json
    end
  end

  def sign_in
    user = User.find_by(email: params[:data][:attributes][:email])
    
    if user && user.authenticate(params[:data][:attributes][:password]) 
      render json: render_element_json(user, UserResource)
    else
      render json: "Not found".to_json
    end
  end

  def confirmation
  	user = User.find_by(confirmation_token: params[:confirmation_token])

  	if user && user.active == false
  	  user.update(active: true)
  	  render json: render_element_json(user, UserResource)
  	else
  	  render json: "Not found".to_json
    end 
  end

end
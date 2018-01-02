class RegistrationsController < ApplicationController
  def sign_up
    return error_response(400, "EMAIL") unless complete_params?(user_sign_params, "email")
    return error_response(400, "PASWWORD") unless complete_params?(user_sign_params, "password")

    email    = user_sign_params[:email]
    password = user_sign_params[:password]

    User.create!(email: email, password: password)
    head :created
  end

  def sign_in
    return error_response(400, "EMAIL") unless complete_params?(user_sign_params, "email")
    return error_response(400, "PASWWORD") unless complete_params?(user_sign_params, "password")
    return error_response(400, "BAD EMAIL/PASSWORD") unless user = User.find_by(email: user_sign_params[:email])
    return error_response(400, "BAD EMAIL/PASSWORD") unless user.authenticate(user_sign_params[:password]) 
    
    render json: { data: { attributes: { token: user.auth_token } } }.to_json, status: 200
  end

  def confirmation
    return error_response(400, "TOKEN") unless complete_params?(user_sign_params, "token")
    return error_response(400, "BAD TOKEN") unless @user = User.find_by(confirmation_token: user_sign_params[:token])
 
    @user.update!(active: true)
    head :ok
  end

  private
    def user_sign_params
      params.require(:data).require(:attributes).permit(:email, :password, :token)
    end
end
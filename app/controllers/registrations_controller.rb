class RegistrationsController < ApplicationController

  def sign_up
    begin
      user = User.create(email: params[:data][:attributes][:email], password: params[:data][:attributes][:password])
      #UserNotificationsMailer.sign_up_mailer(user).deliver

      render json: render_element_json(user, UserResource)
    rescue => e
      handle_exceptions(e)
    end
  end

  def sign_in
  	begin
      user = User.find_by(email: params[:data][:attributes][:email])
    
      if user && user.authenticate(params[:data][:attributes][:password]) 
        render json: render_element_json(user, UserResource)
      end
    rescue => e
      handle_exceptions(e)
    end    
  end

  def confirmation
  	begin
  	  @user = User.find_by(confirmation_token: params[:token])

  	  if @user && @user.active == false
  	    @user.update(active: true)
      end
      respond_to do |format|
        format.html
        format.json { render json: render_element_json(@user, UserResource) }
      end
    rescue => e
      handle_exceptions(e)
    end  
  end

end
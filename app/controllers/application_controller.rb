class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    authenticate_token || render_unauthorized("Access denied")
  end

  def render_unauthorized(message)
    render json: message.to_json, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  def not_found
    render json: "Not found".to_json, status: 404
  end

  def request_response(status:, message:)
    response = {
      status: status,
      message: message
    }
  end

end

class ApplicationController < ActionController::Base

  helper_method :current_user

  include JSONAPI::ActsAsResourceController

  def authenticate!
    authenticate_token || render_unauthorized("Access denied")
  end

  def render_unauthorized(message)
    render json: message.to_json, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
       User.find_by(token: token)
    end
  end

  def not_found
    render json: "Not found".to_json, status: 404
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def request_response(status:, message:)
    response = {
      status: status,
      message: message
    }
  end

  def meta
    { date: "#{Time.now.year}" }
  end

  def context
    # @user assigned in #authorize!()
    { api_user: current_user }
  end

  def render_element_json(element, resource)
    JSONAPI::ResourceSerializer.new(resource).serialize_to_hash(resource.new(element, self))
  end


end

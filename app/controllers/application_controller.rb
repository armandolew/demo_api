class ApplicationController < ActionController::Base
  include JSONAPI::ActsAsResourceController

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error_response(400, parameter_missing_exception.param)
  end

  rescue_from(ActiveRecord::RecordInvalid) do |invalid|
    error_response(422, invalid.record.errors)
  end
=begin
  rescue_from Exception do |exception|
    error_response(422)
  end
=end
  
  # NOTE: DRY, we can handle global exceptions
  # rescue_from do |exception|
  #   handle_exceptions(e)
  # end
  def render_unauthorized(message)
    head :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
       User.find_by(auth_token: token)
    end
  end

  def not_found
    head 404
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def context
    {user: current_user}
  end

  def complete_params?(params, param)
    params.has_key?(param) && !params[param].blank?
  end

  def error_response(code, message)
    render json: { errors: { code: code, detail: message } }, status: code
  end

  def can_perform_action?
    render_unauthorized("Access denied") unless (authenticate_token && current_user && current_user.active) 
  end
end
require 'jwt'

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: -> { Rails.env.development? }
  protect_from_forgery with: :null_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before request go to any controller whatever, Do This!
  before_action :authenticate_request
  
  # middleware to authenticate_user
  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header
    if token.present?
      begin
        decoded_token = JWT.decode(token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256')
        @logged_user = User.find(decoded_token[0])
      rescue JWT::ExpiredSignature
        render json: { error: 'Token has expired' }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
      end
    else
      render json: { error: "Token not provided" }, status: :unauthorized
    end
  end
  

  def get_logged_user  # function return logged user to use it in other controllers..
    @logged_user 
  end  
end


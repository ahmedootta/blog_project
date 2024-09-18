require 'jwt'

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before request go to any controller whatever, Do This!
  before_action :authenticate_request
  
  # middleware to authenticate_user
  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header
    if token.present?
      begin # like try{}
        decoded_token = JWT.decode(token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256') # return list which is: [0] => id & [1] => {'alg'=>'HS256'}
        @logged_user = User.find(decoded_token[0]) # self.logged_user == instance property to be inherited form this class not just variable
      rescue JWT::ExpiredSignature # except
        render json: { error: 'Token has expired' }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
      end
    else
      render json: { error: "Token never sent: #{e.message}" }, status: :unauthorized
    end
  end

  def get_logged_user  # function return logged user to use it in other controllers..
    @logged_user 
  end  
end


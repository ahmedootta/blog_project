# import jwt gem
require 'jwt'

class UsersController < ApplicationController
  # Disable CSRF protection for API requests
  protect_from_forgery with: :null_session

  skip_before_action :authenticate_request, only: [:signup, :login]

  def signup
    user_params = signup_params
  
    if user_params[:password] != user_params[:confirmation_password]
      render json: { error: 'Password and confirmation password do not match' }, status: :unprocessable_entity
      return
    end
  
    user = User.new(user_params.except(:confirmation_password)) # Exclude confirmation_password when creating the user
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login
    email = login_params[:email] # Use login_params to fetch the email
    password = login_params[:password]
    target_user = User.find_by(email: email)

    if target_user && target_user.authenticate(password)
      # get id of user
      user_id = target_user.id
      token = encode_token(user_id) # debug working or not 
      render json: { token: token }, status: :ok # best practice to send JWT in body of response
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end  
      
  end

  private

  def signup_params
    params.permit(:name, :email, :password, :confirmation_password, :image)
  end

  def login_params
    params.permit(:email, :password) # Ensure this method is correctly scoped
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
  end

end

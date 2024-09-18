class UsersController < ApplicationController
  # Disable CSRF protection for API requests
  protect_from_forgery with: :null_session

  def signup
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :image)
  end

  def login
    render plain: "Login Page - POST Request"
  end 
end

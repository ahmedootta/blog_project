class PostsController < ApplicationController
  # disable CSRF middleware
  protect_from_forgery with: :null_session

  def index
    user = get_logged_user
    if user
      # Use the logged-in user
      render json: { message: "Hello, #{user.name}!" }
    else
      render json: { error: "User not found" }, status: :not_found
    end  
  end

  def show
    user = get_logged_user
    if user
      # Use the logged-in user
      render json: { message: "Hello, #{user.name}!" }
    else
      render json: { error: "User not found" }, status: :not_found
    end  
  end

  def create
    user = get_logged_user
    if user
      # Use the logged-in user
      render json: { message: "Hello, #{user.name}!" }
    else
      render json: { error: "User not found" }, status: :not_found
    end  
  end
  
  def update
    user = get_logged_user
    if user
      # Use the logged-in user
      render json: { message: "Hello, #{user.name}!" }
    else
      render json: { error: "User not found" }, status: :not_found
    end  
  end
  
  def destroy
    user = get_logged_user
    if user
      # Use the logged-in user
      render json: { message: "Hello, #{user.name}!" }
    else
      render json: { error: "User not found" }, status: :not_found
    end  
  end

end

class PostsController < ApplicationController
  # disable CSRF middleware
  protect_from_forgery with: :null_session

  # insert new post
  def create
    user = get_logged_user
    tags = post_params[:tags]
    @post = Post.new(post_params.except(:tags).merge(author_id: user.id))
    
    if @post.save
      render json: { message: "Post successfully created!" }
      for index in 0...tags.length
        target_tag = Tag.find_by(name: tags[index]) 
        PostTag.create(post_id: @post.id, tag_id: target_tag.id)
      end 
    else
      render json: { error: "Error saving post" }
    end
  end

  # show all_posts with author_name & tags
  def index
    user = get_logged_user
    all_posts = Post.includes(:author, :tags).all

    render json: all_posts.as_json(
    only: [:id, :title, :body], # Include specific post attributes
    include: {
      author: { only: [:name] }, # Include only the author's name
      tags: { only: [:name] }   # Include only tag names
    }
  )
  end
  
  # get post by_id
  def show
    user = get_logged_user
    id  = params.permit(:id)['id'].to_i
    begin
      target_post = Post.find(id)
      render json: target_post.as_json
    rescue
      render json: { error: "Post doesn't exist!" } 
    end  
  end

  def update
    user_id = get_logged_user.id
    post_id = params.permit(:id)['id'].to_i
    
    begin
      target_post = Post.find(post_id)
      if target_post.author_id == user_id
        begin
          # code to update post...
          render json: { message: "Post has been updated!" }
        rescue
          render json: { error: "Failed to update!"}, status: unprocessable_entity
        end 
      else
        render json: { error: 'Unathorized to update post' }, status: :unauthorized
      end
    rescue
      render json: { error: "Post doesn't exist!" }
    end      
  end
  
  def destroy
    user_id = get_logged_user.id
    post_id = params.permit(:id)['id'].to_i

    begin
      target_post = Post.find(post_id)
      if target_post.author_id == user_id
        begin
          target_post.destroy
          render json: { message: "Post has been deleted!" }
        rescue
          render json: { error: "Failed to delete!"}, status: unprocessable_entity
        end 
      else
        render json: { error: 'Unathorized to delete post' }, status: :unauthorized
      end
    rescue
      render json: { error: "Post doesn't exist!" }
    end      
  end



  private
  def post_params
    params.permit(:title, :body, tags: [])
  end 
end

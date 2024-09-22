class CommentsController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :authenticate_request
  
  # GET ALL COMMENTS FOR POST
  def index
    user_id = get_logged_user.id
    comments = Post.find(comment_params[:post_id]).comments
    post = Post.find(comment_params[:post_id]).title
    comment_data = comments.map do |comment|
      {
        id: comment.id,
        body: comment.body,
        commenter_id: comment.commenter_id,
        commenter_name: comment.commenter.name # Accessing the commenter (author of the comment)
      }
    end
  
    render json: { "Post Id": comment_params[:post_id], "Post Title": post, "All Comments": comment_data }
  end  

  # INSERT COMMENT FOR POST 
  def create
    user_id = get_logged_user.id
    new_comment = Comment.new(comment_params.merge(commenter_id: user_id))
    if new_comment.save
      render json: {message: "Comment added"}, status: :created
    else
      render json: { error: 'Error adding comment!' }, status: :unprocessable_entity  
    end  
  end

  # UPDATE COMMENT BY ITS AUTHOR
  def update
    user_id = get_logged_user.id
    begin
      target_comment = Comment.find(params.permit(:id)['id'].to_i)
      if target_comment.commenter_id == user_id
        begin
          comment_body = comment_params[:body]
          target_comment.update(body: comment_body)
          render json: {message: "Comment updated!"}, status: :created
        rescue
          render json: {error: "Error updating comment!"}, status: :unprocessable_entity  
        end    
      else
        render json: { error: "Unauthorized to update comment!" }, status: :unauthorized  
      end  
    rescue
      render json: { error: "Comment doesn't exist!" }  
    end   
  end

  # DELETE COMMENT BY ITS AUTHOR
  def destroy
    user_id = get_logged_user.id
    begin
      target_comment = Comment.find(params.permit(:id)['id'].to_i)
      if target_comment.commenter_id == user_id
        begin
          target_comment.destroy
          render json: {message: "Comment deleted!"}, status: :created
        rescue
          render json: {error: "Error deleting comment!"} , status: :unprocessable_entity  
        end    
      else
        render json: { error: "Unauthorized to delete comment!" }, status: :unauthorized  
      end  
    rescue
      render json: { error: "Comment doesn't exist!" }
    end   
  end

  private

  def comment_params
    params.permit(:post_id, :body)
  end  
end

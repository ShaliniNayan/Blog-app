class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully added.'
    else
      # Render the post's show page with the form
      render 'posts/show'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def require_user
    redirect_to root_path unless current_user
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

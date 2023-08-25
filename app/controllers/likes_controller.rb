class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(like_params)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Liked the post!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Failed to like the post.'
    end
  end

  private

  def like_params
    params.require(:like).permit(:author_id)
  end
end

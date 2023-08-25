class PostsController < ApplicationController
  def index
    page = params[:page] || 1
    per_page = 10

    @posts = Post.includes(:author)
      .includes(:comments)
      .where(author: params[:user_id])
      .order(created_at: :asc)
      .offset((page.to_i - 1) * per_page)
      .limit(per_page)

    @total_pages = (Post.count.to_f / per_page).ceil
    @author = @posts.first.author
  end

  def show
    @post = Post.find(params[:id])
  end
end

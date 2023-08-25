class PostsController < ApplicationController
  before_action :require_user, except: %i[index show]
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

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = current_user.posts.build
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

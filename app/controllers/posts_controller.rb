class PostsController < ApplicationController
  def index
    per_page = 10
    page = params[:page].to_i
    page = 1 if page <= 0

    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, :comments)
      .order(created_at: :desc)
      .offset((page - 1) * per_page)
      .limit(per_page)

    total_posts = @user.posts.count
    @total_pages = (total_posts.to_f / per_page).ceil
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

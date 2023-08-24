class UsersController < ApplicationController
  def index
    @users = User.all
    @recent_posts = {}
    @users.each do |user|
      @recent_posts[user.id] = user.posts.order(created_at: :desc).limit(5)
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.three_recent_posts
  end
end

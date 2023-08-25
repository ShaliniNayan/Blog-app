class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    user_id = params[:user_id]
    @current_user = User.find_by(id: user_id)
  end

  def require_user
    redirect_to root_path unless @current_user
  end

  attr_reader :current_user

  helper_method :current_user
end

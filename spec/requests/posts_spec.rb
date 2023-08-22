require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      user = create(:user) 
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = create(:user) 
      post = create(:post, user: user)
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to have_http_status(:success)
    end
  end
end
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/1/posts'
      expect(response).to be_successful
    end

    it 'check if correct template was rendered' do
      get '/users/1/posts'
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      get '/users/1/posts'
      expect(response.body).to include('Posts are coming soon!')
    end
  end

  describe 'GET /show' do
    it 'correct response status' do
      get '/users/1/posts/1'
      expect(response).to be_successful
    end

    it 'check if correct template was rendered' do
      get '/users/1/posts/1'
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get '/users/1/posts/1'
      expect(response.body).to include('Here is a list of posts for a given user!')
    end
  end
end

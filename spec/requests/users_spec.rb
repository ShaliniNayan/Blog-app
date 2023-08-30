require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'correct response status' do
      get '/users'
      expect(response).to be_successful
    end

    it 'check if correct template was rendered' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      get '/users'
      expect(response.body).to include('Users are coming soon!')
    end
  end

  describe 'GET /show' do
    it 'correct response status' do
      get '/users/1'
      expect(response).to be_successful
    end

    it 'check if correct template was rendered' do
      get '/users/1'
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get '/users/1'
      expect(response.body).to include('Here are details about the User!')
    end
  end
end

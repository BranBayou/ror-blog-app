require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) { { name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0 } }
  describe 'GET /index' do
    before { User.create!(valid_attributes) }

    it 'returns the correct response status' do
      get users_url
      expect(response).to have_http_status(200)
    end

    it 'response body includes correct placeholder text' do
      get users_url
      expect(response.body).to include('Tom')
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    let(:user) { User.create!(valid_attributes) }

    it 'returns the correct response status' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get user_path(user)
      expect(response.body).to include('Tom')
    end
  end
end

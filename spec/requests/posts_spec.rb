require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 0) }
  let(:valid_attributes) do
    { author: user, text: 'xxxxxxxxxxx', title: 'meeting', comments_counter: 0, likes_counter: 0 }
  end

  describe 'GET /index' do
    before { get user_posts_path(user) }

    it 'returns the correct response status' do
      expect(response).to have_http_status(200)
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Tom')
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'returns the correct response status' do
      post = Post.create!(valid_attributes)
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      post = Post.create!(valid_attributes)
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      post = Post.create!(valid_attributes)
      get user_post_path(user, post)
      expect(response.body).to include('Tom')
    end
  end
end

require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { user.save }

  context 'show page' do
    let(:first_user) { User.first }

    before { visit user_path(first_user) }

    it 'shows profile picture' do
      expect(page).to have_selector("img[src='#{first_user.photo}']")
    end

    it 'shows user name' do
      expect(page).to have_content(first_user.name)
    end

    it 'shows number of posts by the user' do
      expect(page).to have_content("Number of posts: #{first_user.posts_counter}")
    end

    it "shows a button that lets me view all of a user's posts" do
      expect(page).to have_selector('a', text: 'See all post')
    end
  end

  context 'show' do
    let(:first_user) { User.first }
    let(:first_user_posts) { first_user.recent_posts }

    before { visit user_path(first_user) }

    it 'shows user bio' do
      expect(page).to have_content(first_user.bio.to_s)
    end

    it 'displays the first three posts and a "Show All" button' do
      first_post = first_user_posts[0]
      second_post = first_user_posts[1]
      third_post = first_user_posts[2]

      expect(page).to have_content(first_post.title) if first_post
      expect(page).to have_content(second_post.title) if second_post
      expect(page).to have_content(third_post.title) if third_post
      expect(page).to have_selector('a', text: 'See all posts')
    end
  end

  context 'Clicks' do
    let(:first_user) { User.first }

    before { visit user_path(first_user) }

    it "redirects me to the user's post on clicking on a post" do
      first_user.recent_posts.each do |post|
        click_link post.title
        expect(page).to have_current_path(user_post_path(first_user, post))
        visit user_path(first_user)
      end
    end

    it "redirects me to the user's post clicking on see all posts" do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(first_user))
    end
  end
end

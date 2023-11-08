require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { user.save }

  describe 'index page' do
    before { visit user_posts_path(user) }

    it 'shows the user name' do
      expect(page).to have_content(user.name)
    end

    it "shows the user's profile picture" do
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'shows the number of posts for each user' do
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
    context 'Click' do
      let(:first_recent_post) { user.recent_posts[0] }
      it "redirects me to that post's show page when I click on a post" do
        if first_recent_post
          click_link first_recent_post.title
          expect(page).to have_current_path(user_post_path(user, first_recent_post))
        end
      end
    end
    context 'when a recent post exists' do
      let(:first_recent_post) { user.recent_posts[0] }
      let(:first_recent_comment) { post.recent_comments[0] }
      it "shows the recent post's title" do
        expect(page).to have_content(first_recent_post.title) if first_recent_post
      end

      it "shows some of the recent post's body" do
        if first_recent_post
          expected_text = if first_recent_post.text.length > 200
                            "#{first_recent_post.text[0,
                                                      200]}..."
                          else
                            first_recent_post.text
                          end
          expect(page).to have_content(expected_text)
        end
      end

      it 'shows the number of comments for the recent post' do
        expect(page).to have_content("Comments: #{first_recent_post.comments_counter}") if first_recent_post
      end
      it 'asserts you can see the first comments on a post' do
        expect(page).to have_content(first_recent_comment) if first_recent_post
      end
      it 'shows the number of likes for the recent post' do
        expect(page).to have_content("Likes: #{first_recent_post.likes_counter}") if first_recent_post
      end
    end

    it 'shows a section for pagination' do
      expect(page).to have_selector('a', text: 'Pagination')
    end
  end
end

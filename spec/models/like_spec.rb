require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User').with_foreign_key('author_id') }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    describe 'after_save' do
      let(:user) { User.create(name: 'bran') }
      let(:post) { Post.create(title: 'Test Post') }
      let(:like) { Like.create(user: user, post: post) }
    end
  end
end

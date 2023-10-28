require 'rails_helper'

RSpec.describe User, type: :model do
  context 'testing user with no values' do
    subject { User.new }
    before { subject.save }

    it 'require user to have name' do
      expect(subject).to_not be_valid
    end
  end
  context 'testing user with values' do
    subject(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
    before { user.save }

    it 'user with name should be valid' do
      expect(user).to be_valid
    end

    it 'posts counter should be equal to 0' do
      expect(user.posts_counter).to eq(0)
    end
  end
end

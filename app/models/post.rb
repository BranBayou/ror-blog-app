class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }

  def update_posts_counter
    author_posts = author.posts_counter.nil? ? 0 : author.posts_counter
    author.update(posts_counter: author_posts + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end

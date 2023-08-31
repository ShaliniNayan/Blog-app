class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :update_posts_counter

  before_validation :set_counter_to_zero

  def set_counter_to_zero
    self.comments_counter = 0 if comments_counter.nil?
    self.likes_counter = 0 if likes_counter.nil?
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def five_recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end
end

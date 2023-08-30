require 'rails_helper'

describe Post, type: :model do
  it 'validate title exists' do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
  end

  it 'validate length of title' do
    post = Post.new(title: 'a' * 251)
    expect(post).to_not be_valid
  end

  it 'validates numericality of comments_counter' do
    post = Post.new(comments_counter: -1)
    expect(post).to_not be_valid
  end

  it 'validates numericality of likes_counter' do
    post = Post.new(likes_counter: -1)
    expect(post).to_not be_valid
  end

  it 'increments the author posts_counter by 1' do
    author = User.create!(name: 'John Doe', posts_counter: 0)
    post = Post.new(title: 'Title', comments_counter: 0, likes_counter: 0, author:)
    expect { post.save! }.to change { author.reload.posts_counter }.by(1)
  end

  it 'returns the five most recent comments' do
    author = User.create!(name: 'John Doe', posts_counter: 0)
    post = Post.create!(title: 'Title', comments_counter: 0, likes_counter: 0, author:)
    older_comments = 6.times.map { Comment.create!(post:, text: 'Old comment', author:) }
    recent_comment = Comment.create!(post:, text: 'Recent comment', author:)

    expect(post.five_recent_comments).to include(recent_comment)
    expect(post.five_recent_comments.length).to eq(5)
    expect(post.five_recent_comments).to_not include(older_comments.first)
  end
end

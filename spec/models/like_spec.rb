require 'rails_helper'

describe Like, type: :model do
  describe '#update_likes_counter' do
    it 'increments the post likes_counter by 1' do
      user = User.create!(name: 'User Name', posts_counter: 0)
      post = Post.create!(author: user, title: 'Post Title', comments_counter: 0, likes_counter: 0)
      like = Like.new(author: user, post:)
      expect(post.likes_counter).to eq 0
      like.save!
      post.reload
      expect(post.likes_counter).to eq 1
    end
  end
end

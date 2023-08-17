require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Welcome', author: User.create(name: 'Ali')) }

  before { subject.save }

  describe 'validation tests' do
    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should be less than 251 chars' do
      subject.title = 'Lorem ipsum dolor sit amet,
      consectetuer adipiscing elit. Aenean commodo ligula
      eget dolor. Aenean massa. Cum sociis natoque penatibus
      et magnis dis parturient montes, nascetur ridiculus mus.
      Donec quam felis, ultricies neln ea' # 251 chars
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be integer' do
      subject.comments_counter = 'hey'
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -2
      expect(subject).to_not be_valid
      subject.comments_counter = 0
      expect(subject).to be_valid
    end

    it 'likes_counter should be integer' do
      subject.likes_counter = 'hey'
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to zero' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
      subject.likes_counter = 0
      expect(subject).to be_valid
    end
  end

  describe '#update_user_posts_counter' do
    it 'updates the user posts_counter attribute' do
      user = User.create(name: 'Sam')
      post = Post.create(title: 'Hello', author: user)

      post.update_user_posts_counter

      expect(user.reload.posts_counter).to eq(1)
    end
  end

  describe '#five_most_recent_comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'Salim')
      comment1 = Comment.create(author: user, post: subject, text: 'comment 1', created_at: 5.day.ago)
      comment2 = Comment.create(author: user, post: subject, text: 'comment 2', created_at: 4.day.ago)
      comment3 = Comment.create(author: user, post: subject, text: 'comment 3', created_at: 3.day.ago)
      comment4 = Comment.create(author: user, post: subject, text: 'comment 4', created_at: 2.day.ago)
      comment5 = Comment.create(author: user, post: subject, text: 'comment 5', created_at: 1.day.ago)

      reecent_comments = subject.five_most_recent_comments

      expect(reecent_comments).to eq([comment5, comment4, comment3, comment2, comment1])
    end
  end
end

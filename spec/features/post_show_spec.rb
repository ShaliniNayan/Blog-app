require 'rails_helper'

RSpec.feature 'Post Show', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png', bio: 'He is a good programmar') }
  let!(:post) { Post.create(author: user, title: "first post's title", text: 'first text') }
  let!(:post2) { Post.create(author: user, title: 'second post', text: 'second text') }
  let!(:post3) { Post.create(author: user, title: 'third post', text: '3 text') }
  let!(:post4) { Post.create(author: user, title: '4 post', text: '4 text') }
  let!(:comment1) { Comment.create(author: user, post:, text: 'first comment') }
  let!(:comment2) { Comment.create(author: user, post:, text: 'second comment') }
  let!(:comment3) { Comment.create(author: user, post:, text: 'third comment') }
  let!(:like1) { Like.create(author: user, post:) }
  scenario 'see the title of the post and who wrote it and the interactions' do
    visit user_post_path(user, post)
    expect(page).to have_content("first post's title")
    expect(page).to have_content('by Tom')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 1')
  end

  scenario "see the post's body" do
    visit user_post_path(user, post)
    expect(page).to have_content('first text')
  end

  scenario 'see the username and comment of each post' do
    user2 = User.create(name: 'Ali')
    user3 = User.create(name: 'Shalini')
    Comment.create(author: user2, post:, text: 'fifth comment')
    Comment.create(author: user3, post:, text: 'sixth comment')

    visit user_post_path(user, post)

    expect(page).to have_content('Tom')
    expect(page).to have_content('Shalini')
    expect(page).to have_content('sixth comment')
  end
end

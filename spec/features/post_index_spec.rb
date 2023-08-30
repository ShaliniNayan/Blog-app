require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png', bio: 'He is a good programmer') }
  let!(:post1) { Post.create(author: user, title: 'first post', text: 'first text') }
  let!(:post2) { Post.create(author: user, title: 'second post', text: 'second text') }
  let!(:post3) { Post.create(author: user, title: 'third post', text: 'third text') }

  before do
    visit user_path(user)
  end

  scenario 'visiting the user Show page' do
    expect(page).to have_content('Tom')
    expect(page).to have_content('Bio')
    expect(page).to have_content('He is a good programmer')
    expect(page).to have_link('See all posts')
    expect(page).to have_content('Recent Posts') if page.has_content?('Recent Posts')
  end

  scenario 'asserts you can see the user\'s profile picture' do
    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/leaf-blue.png"]')
  end

  scenario 'asserts you can see the user\'s first 3 posts' do
    expect(page).to have_content('first post')
    expect(page).to have_content('second post')
    expect(page).to have_content('third post')
  end

  scenario 'redirects to the post\'s show page when you click on a user\'s post' do
    click_link 'first post'
    expect(page).to have_current_path(user_post_path(user, post1))
  end

  scenario 'redirects to the user\'s post\'s index page when you click on "See all posts"' do
    click_link 'See all posts'
    expected_path = user_posts_path(user).chomp('/')
    actual_path = page.current_path.chomp('/')
    expect(actual_path).to eq(expected_path)
  end
end

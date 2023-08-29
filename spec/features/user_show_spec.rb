require 'rails_helper'

RSpec.feature 'User Show', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png', bio: 'He is a good programmer') }
  let!(:post1) { Post.create(author: user, title: 'first post', text: 'first text') }
  let!(:post2) { Post.create(author: user, title: 'second post', text: 'second text') }

  scenario 'visiting the user Show page' do
    visit user_path(user)

    expect(page).to have_content('Tom')
    expect(page).to have_content('Bio')
    expect(page).to have_content('He is a good programmer')


    expect(page).to have_link('See all posts')

    expect(page).to have_content('first post')
    expect(page).to have_link('first post', href: user_post_path(user, post1))
    expect(page).to have_content('second post')
    expect(page).to have_link('second post', href: user_post_path(user, post2))

    expect(page).to have_content('Recent Posts') if page.has_content?('Recent Posts')
  end
end

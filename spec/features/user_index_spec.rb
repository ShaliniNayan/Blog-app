require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
  scenario 'visiting the user index page' do
    User.create(name: 'Tom', photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png')
    User.create(name: 'Ali', photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png')

    visit users_path

    expect(page).to have_content('Tom')
    expect(page).to have_content('Ali')
  end

  scenario 'visiting the user index page, you see the number of posts each user has written..' do
    user1 = User.create(name: 'Tom')
    User.create(name: 'Ali')
    Post.create(author: user1, title: 'first post')
    Post.create(author: user1, title: 'second post')
    Post.create(author: user1, title: 'third post')

    visit users_path

    expect(page).to have_content('3')
    expect(page).to have_content('0')
  end

  scenario 'clicking on a user redirects to their show page' do
    user = User.create(name: 'Shalini')

    visit users_path

    click_link 'Shalini'

    expect(page).to have_current_path(user_path(user))
  end
end

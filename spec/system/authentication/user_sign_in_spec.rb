require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # arrange
    User.create!(email: 'user@email.com', password: '123456')

    # act
    visit(root_path)
    within('nav') do
      click_on('Sign in')
    end
    within('form') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: '123456'
      click_on('Sign in')
    end

    # assert
    within('nav') do
      expect(page).not_to have_link('Sign in')
      expect(page).to have_button('Sign out')
      expect(page).to have_content('user@email.com')
    end
    expect(page).to have_content('Signed in successfully')
  end

  it 'and sign out' do
    # arrange
    User.create!(email: 'user@email.com', password: '123456')

    # act
    visit(root_path)
    within('nav') do
      click_on('Sign in')
    end
    within('form') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: '123456'
      click_on('Sign in')
    end
    within('nav') do
      click_on('Sign out')
    end

    # assert
    within('nav') do
      expect(page).to have_link('Sign in')
      expect(page).not_to have_button('Sign out')
      expect(page).not_to have_content('user@email.com')
    end
    expect(page).to have_content('Signed out successfully')
  end
end

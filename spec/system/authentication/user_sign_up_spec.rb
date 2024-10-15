require 'rails_helper'

describe 'User sign up' do
  it 'successfully' do
    # arrange

    # act
    visit(root_path)
    within('nav') do
      click_on('Sign in')
    end
    click_on('Sign up')
    within('form') do
      fill_in 'Name', with: 'User'
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on('Sign up')
    end

    # assert
    within('nav') do
      expect(page).not_to have_link('Sign in')
      expect(page).to have_button('Sign out')
      expect(page).to have_content('User - user@email.com')
    end
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
end

def sign_in(user)
  within('nav') do
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
  end
  within('form') do
    click_on 'Sign in'
  end
end

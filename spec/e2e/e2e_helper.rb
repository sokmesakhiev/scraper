def login(email:, password:)
  visit '/'
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password

  click_button 'Sign in'
end

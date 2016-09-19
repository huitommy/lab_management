require 'rails_helper'

feature 'User creates a new account:', js: true do

  before :each do
    visit root_path
    click_link('Sign Up', match: :first)
  end

  scenario 'user can create an account' do
    fill_in 'username', with: 'labtech'
    fill_in 'email', with: 'test@test.test'
    fill_in 'password', with: 'password'
    fill_in 'password-confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
  end

  scenario 'user attempts to use an username that already exists' do
    FactoryGirl.create(:user, username: 'labtech')

    fill_in 'username', with: 'labtech'
    fill_in 'email', with: 'anothertestemail@test.test'
    fill_in 'password', with: 'anotherpassword'
    fill_in 'password-confirmation', with: 'anotherpassword'
    click_on 'Sign up'

    expect(page).to have_content('Username has already been taken')
  end

  scenario 'user attempts to use an username that already exists' do
    FactoryGirl.create(:user, email: 'email@example.com')

    fill_in 'username', with: 'labtech'
    fill_in 'email', with: 'email@example.com'
    fill_in 'password', with: 'anotherpassword'
    fill_in 'password-confirmation', with: 'anotherpassword'
    click_on 'Sign up'

    expect(page).to have_content('Email has already been taken')
  end

  scenario 'user does not submit an email' do
    fill_in 'username', with: 'labtech'
    fill_in 'password', with: 'password'
    fill_in 'password-confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content("Email can't be blank")
  end

  scenario 'user does not submit username' do
    fill_in 'email', with: 'test@test.test'
    fill_in 'password', with: 'password'
    fill_in 'password-confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content("Username can't be blank")
  end

  scenario 'user does not add password confirmation' do
    fill_in 'email', with: 'test@test.test'
    fill_in 'password', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'user password and confirmation do not match' do
    fill_in 'email', with: 'test@test.test'
    fill_in 'password', with: 'password'
    fill_in 'password-confirmation', with: 'pasword'
    click_on 'Sign up'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end

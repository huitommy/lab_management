require 'rails_helper'

feature 'User creates new order request' do

  context 'user is signed in' do
    before(:each) do
      FactoryGirl.create(:vendor, name: 'vendor1')
      FactoryGirl.create(:vendor, name: 'vendor2')
      FactoryGirl.create(:user, username: 'labtech', email: 'labtech@email.com', password: 'password')
      visit new_user_session_path
      fill_in 'Login', with: 'labtech@email.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      click_on 'New Order Request'
    end

    scenario 'User visits page with new order request form and selects a vendor' do
      click_link 'New Order Request'
      select "vendor1", from: "Vendor:"
      click_on 'Create Order'

      expect(page).to have_content('You have created the order request successfully')
      expect(page).to have_content('vendor1')
    end
  end

  scenario 'User is not logged in and tries to submit a new order request form' do
    visit new_order_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

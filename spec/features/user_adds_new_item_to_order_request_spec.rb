require 'rails_helper'

feature 'User creates new order request' do

  context "user is signed in" do
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

    scenario 'User visits page with new order request form and fills it out correctly' do
      click_link 'New Order Request'
      select "vendor1", from: "Vendor:"
      fill_in 'Cat number', with: '34344'
      fill_in 'Product name', with: 'test'
      fill_in 'Quantity', with: '23'
      fill_in 'Price', with: '142'
      fill_in 'URL', with: 'http://wwww.google.com'
      click_on 'Create Order'

      expect(page).to have_content('You have added the order successfully')
      expect(page).to have_content('test')
      expect(page).to have_content('34344')
      expect(page).to have_content('test')
      expect(page).to have_content('23')
      expect(page).to have_content('142')
      expect(page).to have_content('http://wwww.google.com')
    end

    scenario 'User visits page with new elevader form and fills out incorrectly' do
      click_link 'New Order Request'
      select "vendor1", from: "Vendor:"
      fill_in 'Product name', with: 'test'
      fill_in 'Quantity', with: '23'
      fill_in 'Price', with: '142'
      fill_in 'URL', with: 'http://wwww.google.com'
      click_on 'Create Order'

      expect(page).to have_content("Cat number can't be blank")
      expect(page).to_not have_content('test')
      expect(page).to have_selector("input[value = 'test']")
      expect(page).to have_selector("input[value = '23']")
      expect(page).to have_selector("input[value = '142']")
      expect(page).to have_selector("input[value = 'http://wwww.google.com']")
    end
  end

  scenario 'User is not logged in and tries to submit a new order request form' do
    visit new_order_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

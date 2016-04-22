require 'rails_helper'

feature 'User adds new item to order request' do

  context "user is signed in:" do
    before(:each) do
      FactoryGirl.create(:vendor, name: 'vendor1')
      FactoryGirl.create(:vendor, name: 'vendor2')
      FactoryGirl.create(:user, username: 'labtech', email: 'labtech@email.com', password: 'password')
      visit new_user_session_path
      fill_in 'Login', with: 'labtech@email.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      click_on 'New Order Request'
      select 'vendor1', from: 'Vendor:'
      click_on 'Create Order'
    end

    scenario 'adds an item after creating a new order request' do
      fill_in 'Cat number', with: 'ABC123'
      fill_in 'Product name', with: 'Test Product'
      fill_in 'Quantity', with: '2'
      fill_in 'Price', with: '15.25'
      fill_in 'URL', with: 'http://www.google.com'
      click_on 'Add Item'

      expect(page).to have_content('Item Added!')
      expect(page).to have_content('ABC123')
      expect(page).to have_content('Test Product')
      expect(page).to have_content('2')
      expect(page).to have_content('15.25')
      expect(page).to have_content('http://www.google.com')
    end

    scenario 'adds an item to exisiting order request' do
      visit orders_path
      click_on 'vendor1'
      fill_in 'Cat number', with: 'ABC123'
      fill_in 'Product name', with: 'Test Product'
      fill_in 'Quantity', with: '2'
      fill_in 'Price', with: '15.25'
      fill_in 'URL', with: 'http://www.google.com'
      click_on 'Add Item'

      expect(page).to have_content('Item Added!')
      expect(page).to have_content('ABC123')
      expect(page).to have_content('Test Product')
      expect(page).to have_content('2')
      expect(page).to have_content('15.25')
      expect(page).to have_content('http://www.google.com')
    end
  end

  scenario 'User is not logged in and tries to add a new item form' do
    visit orders_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

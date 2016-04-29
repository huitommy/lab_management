require 'rails_helper'

feature 'User adds new item to order request', js: true do

  context "user is signed in:" do
    before(:each) do
      FactoryGirl.create(:vendor, name: 'vendor1')
      FactoryGirl.create(:vendor, name: 'vendor2')
      @user1 = FactoryGirl.create(:user, username: 'labtech', email: 'labtech@email.com')
      @user2 = FactoryGirl.create(:user, username: 'labtech1', email: 'labtech1@email.com')
      sign_in_as(@user1)
      click_on 'New Order Request'
      select 'vendor1', from: 'Vendor:'
      click_on 'Create Order'
    end

    scenario 'adds an item after creating a new order request' do
      fill_in_order

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
      fill_in_order

      expect(page).to have_content('Item Added!')
      expect(page).to have_content('ABC123')
      expect(page).to have_content('Test Product')
      expect(page).to have_content('2')
      expect(page).to have_content('15.25')
      expect(page).to have_content('http://www.google.com')
    end

    scenario "any user can add items to an exisiting order request as long as it's not marked as 'ordered'" do
      click_on 'Sign Out'
      sign_in_as(@user2)
      click_on 'Orders'
      click_on 'vendor1'
      fill_in_order

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

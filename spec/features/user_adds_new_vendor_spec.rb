require 'rails_helper'

feature 'User adds new vendor:', js: true do

  context "user is signed in" do
    before(:each) do
      user1 = FactoryGirl.create(:user, username: 'labtech', email: 'labtech@email.com', password: 'password')
      sign_in_as(user1)
    end

    scenario 'User visits page with new vendor form and fills it out correctly' do
      click_link 'New Vendor'
      fill_in 'Name', with: 'test'
      fill_in 'Address', with: 'test street'
      fill_in 'City', with: 'test city'
      select 'Massachusetts', from: 'State'
      fill_in 'Zip Code', with: '02142'
      fill_in 'Telephone', with: '2337423773'
      click_on 'Create Vendor'

      expect(page).to have_content('You have added the vendor successfully')
      expect(page).to have_content('test')
    end

    scenario 'User visits page with new vendor form and fills out incorrectly' do
      click_link 'New Vendor'
      fill_in 'Address', with: 'test street'
      fill_in 'City', with: 'teston'
      select 'Massachusetts', from: 'State'
      fill_in 'Zip Code', with: '02142'
      click_on 'Create Vendor'

      expect(page).to have_content("Name can't be blank")
      expect(page).to_not have_content('test')
      expect(page).to have_selector("input[value='test street']")
      expect(page).to have_selector("input[value ='02142']")
    end
  end

  scenario 'User is not logged in and tries to submit a new vendor form' do
    visit vendors_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

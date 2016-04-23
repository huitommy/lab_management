require 'rails_helper'

feature 'Search bar:' do

  before(:each) do
    v1 = FactoryGirl.create(:vendor, name: 'VWR')
    v2= FactoryGirl.create(:vendor, name: 'Fisher Scientific')
    v3= FactoryGirl.create(:vendor, name: 'Sigma Aldrich')
    vwr = FactoryGirl.create(:order, vendor: v1)
    fisher = FactoryGirl.create(:order, vendor: v2)
    sigma = FactoryGirl.create(:order, vendor: v3)
    FactoryGirl.create(:item, product_name: "test tube", order: vwr)
    FactoryGirl.create(:item, product_name: "pipette", order: sigma)
    FactoryGirl.create(:item, product_name: "beaker", order: fisher )
  end

  context 'user is signed in:' do
    before(:each) do
      user1 = FactoryGirl.create(:user, email: 'email@email.com', password: 'password')
      sign_in_as(user1)
      visit orders_path
    end

    scenario 'searches for a specific vendor' do
      fill_in 'query', with: 'VWR'
      click_on 'Search Orders'

      expect(page).to have_content('VWR')
      expect(page).to_not have_content('Sigma Aldrich')
      expect(page).to_not have_content('Fisher Scientific')
    end

    scenario 'searches for a item' do
      fill_in 'query', with: 'pipette'
      click_on 'Search Orders'

      expect(page).to have_content('Sigma Aldrich')
      expect(page).to_not have_content('VWR')
      expect(page).to_not have_content('Fisher Scientific')

      click_on 'Sigma Aldrich'
      expect(page).to have_content('pipette')
    end

    scenario 'User enters search term for which there are no matches' do
      fill_in 'query', with: 'antibody'
      click_on 'Search Orders'

      expect(page).to have_content("Sorry, but we couldn't find any orders matching 'antibody'")
    end

    scenario 'user can go to order show pages from results' do
      fill_in 'query', with: 'VWR'
      click_on 'Search Orders'
      click_link("VWR")

      expect(page).to have_content('VWR')
      expect(page).to have_content('Order #')
    end
  end

  scenario 'Non-logged-in user searches for a specific order' do
    visit root_path
    fill_in 'query', with: 'VWR'
    click_button 'Search Orders'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

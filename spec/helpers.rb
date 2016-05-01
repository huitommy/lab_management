module Helpers
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'username', with: "#{user.username}"
    fill_in 'password', with: 'password'
    click_on 'Log in'
  end

  def fill_in_order
    fill_in 'Cat number', with: 'ABC123'
    fill_in 'Product name', with: 'Test Product'
    fill_in 'Quantity', with: '2'
    fill_in 'Price', with: '15.25'
    fill_in 'URL', with: 'http://www.google.com'
    click_on 'Add Item'
  end
end

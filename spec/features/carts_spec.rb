require 'spec_helper'

feature 'Carts' do
  background do
    visit '/'
    find('#main').first('.button_to').click_button 'Add to Cart'
  end
  context "Store index" do
    scenario "Checkout button links to order form" do
      click_button('Checkout')

      current_url.should have_content('orders/new')
    end

    scenario "Empty cart button restarts the cart" do
      click_button('Empty cart')

      expect(page).to_not have_content('Your cart')
    end

    scenario "Product counter increases when new product is added" do
      find('#main').first('.button_to').click_button 'Add to Cart'

      expect(find('#cart').first('td')).to have_content('2')      
    end
  end
end
require 'spec_helper'

feature 'LineItem' do
  context 'Generate ajax cart with line items' do
    scenario "hidden when theres no line items" do
      visit '/'
      expect(page).to_not have_content('Your Cart')
    end
    scenario "adds an new item when user clicks add to cart" do
      visit '/'
      first('.button_to').click_button 'Add to Cart'
      
      expect(page).to have_content('Your Cart')
    end
    scenario "adds a new item when user clicks on product image", :js => true do
      visit '/'
      first(".productimg").click

      expect(page).to have_content('Your Cart')
    end
  end
end
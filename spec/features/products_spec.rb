require 'spec_helper'
include Warden::Test::Helpers

feature 'Products' do
  context "as admin" do
    let(:user){FactoryGirl.create(:user, email:"matiasmoya@gmail.com", password:"asdqwe123", admin: true)}
    let(:product){FactoryGirl.create(:product)}
    before(:each) do
      login_as(user, scope: :user)
    end

    scenario "Shows properly as admin user" do
      visit "/products"
      expect(page).to have_content('Listing product')
      expect(current_path).to eq(products_path)
    end
    scenario "Creates a product" do
      visit "/en/products"
      click_link ('New product')
      expect(current_path).to eq('/en/products/new')
      fill_in 'Title', :with => 'Titulo de un producto'
      fill_in 'Description', :with => 'Una descripcion breve para un producto nuevo'
      fill_in 'product_image_url', :with => 'ruby.jpg'
      fill_in 'product_price', :with => '99'
      click_button 'Create Product'
      expect(page).to have_content('Product was successfully created')
      click_link 'Back'
      click_link 'Destroy'
    end
    scenario "Edit a product" do
      product = FactoryGirl.create(:product)
      visit products_path
      expect(page).to have_content('Edit')
      click_link 'Edit'
      expect(current_path).to have_content('/edit')
      fill_in 'Title', :with => 'Titulo nuevo'
      click_button 'Update Product'
      expect(page).to have_content('Product was successfully updated.')
      DatabaseCleaner.clean
    end
    scenario "Shows a product" do
      product = FactoryGirl.create(:product)
      visit products_path
      click_link 'Show'
      expect(page).to have_content('Game of thrones')
    end
    # scenario "destroy a product", :js => true do
    #   product = FactoryGirl.create(:product)
    #   visit products_path
    #   click_link ('New product')
    #   expect(current_path).to eq('/en/products/new')
    #   fill_in 'Email', with => 'matiasmoya@gmail.com'
    #   fill_in 'Password', with => 'asdqwe123'
    #   click_button 'Sign in'
    #   fill_in 'Title', :with => 'Titulo de un producto'
    #   fill_in 'Description', :with => 'Una descripcion breve para un producto nuevo'
    #   fill_in 'product_image_url', :with => 'ruby.jpg'
    #   fill_in 'product_price', :with => '99'
    #   click_button 'Create Product'
    #   expect(page).to have_content('Product was successfully created')
    #   click_link 'Back'
    #   click_link "Destroy"
    #   alert = page.driver.browser.switch_to.alert
    #   alert.accept
    # end
  end


  context "as normal user" do
    let(:user){FactoryGirl.create(:user, email:"another@gmail.com", password:"asdqwe123", admin: false)}
    before(:each) do
      login_as(user, scope: :user)
    end
    scenario "doesnt shows to regular users" do
      visit "/products"
      expect(page).to_not have_content('Listing product')
      expect(current_path).to_not eq(products_path)
    end
  end
end
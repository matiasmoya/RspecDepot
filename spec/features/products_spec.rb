require 'spec_helper'

feature 'Products' do
  context "as admin" do
    let(:user) { create(:user, :admin) }
    let(:product) { create(:product) }

    background do
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

      fill_in 'Title',             :with => 'Titulo de un producto'
      fill_in 'Description',       :with => 'Una descripcion breve para un producto nuevo'
      fill_in 'product_image_url', :with => 'ruby.jpg'
      fill_in 'product_price',     :with => '99'

      click_button 'Create Product'

      expect(Product.all).to_not be_empty
      expect(page).to have_content('Product was successfully created')
    end

    scenario "Edit a product" do
      product = create(:product)
      visit products_path
      all(:css, '.list_actions').last.click_link 'Edit'

      fill_in 'Title', :with => 'Titulo nuevo'

      click_button 'Update Product'

      expect(product.reload.title).to eql('Titulo nuevo')
      expect(page).to have_content('Product was successfully updated.')
    end

    scenario "Shows a product" do
      product = create(:product)
      visit products_path
      first('.list_actions').click_link 'Show'

      expect(page).to have_content('Showing product')
    end

    scenario "destroy a product" do
      product = create(:product)
      visit products_path
      
      all(:css, '.list_actions').last.click_link 'Destroy'

      expect(Product.where(:title => product.title)).to be_empty
    end
  end


  context "as normal user" do
    let(:user){ create(:user) }

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

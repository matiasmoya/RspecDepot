require 'spec_helper'

feature 'Orders' do
  context 'as normal user' do
    let(:user) { create(:user) }
    
    background do
      login_as(user, scope: :user)
    end
    scenario 'Creates an order' do
      visit ('/')
      find('#main').first('.button_to').click_button 'Add to Cart'
      
      click_button('Checkout')

      current_url.should have_content('orders/new')
      
      fill_in 'order_name',        :with => 'Order'
      fill_in 'order_address',     :with => 'Order adress 123'
      fill_in 'order_email',       :with => 'order@order.com'
      select 'Tarjeta de credito', :from => 'order_pay_type'

      expect{
        click_button('Realizar orden')
      }.to change{ Order.count }.by(1)

      expect(page).to have_content('Gracias por su compra!')
      
      expect(last_email.to).to include("order@order.com")
      expect(last_email.subject).to eql("Pragmatic Store order confirmation")
    end

    scenario 'Doesnt allow access to order administration' do
      visit ('/en/orders')

      expect(current_path).to_not eq(orders_path)
    end
  end

  context 'as admin user' do
    let(:user) { create(:user, :admin) }
    let(:order) { create(:order) }

    background do
      login_as(user, scope: :user)
    end
    scenario 'Show orders index' do
      visit ('/en/orders')

      current_url.should have_content('orders')
    end
    scenario 'Shows an specific order' do
      visit ('/en/orders')
      
      all(:css, '#main').last.click_link 'Show'
      expect(page).to have_content('Showing order')
    end
    scenario 'Edits an order' do
      order = create(:order)
      visit ('/en/orders')

      all(:css, '.order_actions').last.click_link 'Edit'
      fill_in 'order_name', :with => 'New order name'

      click_button 'Realizar orden'
      
      expect(order.reload.name).to eql('New order name')
      expect(page).to have_content('Order was successfully updated')
    end
    scenario 'Destroy an order' do
      order = create(:order)
      visit orders_path

      all(:css, '.order_actions').last.click_link 'Destroy'

      expect(Order.where(:name => order.name)).to be_empty
    end
  end
end

require 'spec_helper'
describe Cart do
  describe "Associations" do
    it { should have_many(:line_items).dependent(:destroy) }
  end

  it "Has a valid factoryGirl" do
    build(:line_item).should be_valid
  end

  describe "#add_product(product_id)" do
    it "adds a product to the cart by product id" do 
    end
    it "sums line items and shows total price" do
      # item = create(:line_item, :many)
      # another = create(:line_item)
      # cart = create(:cart)
      # cart.total_price.should eq(item.total_price)
      #to.ask :P
    end
  end

end
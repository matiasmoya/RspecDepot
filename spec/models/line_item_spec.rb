require 'spec_helper'

describe LineItem do
  it "has a valid factoryGirl" do
    build(:line_item).should be_valid
  end

  describe "Associations" do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
    it { should belong_to(:cart) }
  end

  describe "Validations" do
    it { should validate_presence_of(:product) }
  end

  it "is not valid without product id" do
    build(:line_item, product_id: nil).should_not be_valid
  end

  describe "#total_price" do
    it "returns product price * line item quantity" do
      line = create(:line_item)
      line.total_price.should eq( line.product.price * line.quantity )
    end
  end
end

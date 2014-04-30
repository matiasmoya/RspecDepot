require 'spec_helper'

describe Product do
  it "has a valid factoryGirl" do
    FactoryGirl.build(:product).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:product, title: nil).should_not be_valid
  end
  it "is invalid without a image_url" do
    FactoryGirl.build(:product, image_url: nil).should_not be_valid
  end
  it "is invalid without a description" do
    FactoryGirl.build(:product, description: nil).should_not be_valid
  end
  it "is invalid if theres double titles" do
    product = FactoryGirl.create(:product, title: 'duplicate me')
    FactoryGirl.build(:product, title: 'duplicate me').should_not be_valid
  end
  it "is invalid if the price has wrong data" do
     should validate_numericality_of :price
  end

  # it {should validate_presence_of :title}
  # it {should validate_presence_of :image_url}
  # it {should validate_presence_of :description}
  # it {should validate_uniqueness_of :title}
  # it { should validate_numericality_of :price}
end
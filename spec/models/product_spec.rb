require 'spec_helper'

describe Product do
  it "has a valid factoryGirl" do
    expect{
      create(:product)
    }.to change{ Product.count }.by(1)
  end

  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :image_url }
    it { should validate_presence_of :description }
    it { should validate_uniqueness_of :title }
    it { should validate_numericality_of :price }
  end
end
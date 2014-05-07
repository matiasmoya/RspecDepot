require 'spec_helper'

describe Order do
  it "has a valid factoryGirl" do
    expect{
      create(:order)
    }.to change{ Order.count }.by(1)
  end
  
  describe "Associations" do
    it {should have_many(:line_items).dependent(:destroy) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:email) }
    # it { should ensure_inclusion_of(:pay_type), :in=>["Cheques", "Tarjeta de credito", "Orden de compra"] }
    it { should allow_value("Cheques").for(:pay_type) }
    it { should allow_value("Tarjeta de credito").for(:pay_type) }
    it { should allow_value("Orden de compra").for(:pay_type) }
    it { should_not allow_value("other").for(:pay_type) }
  end
end

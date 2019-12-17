require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it "should create a product with a valid name, price, quantity and category" do
      @category = Category.new(name: "Test")
      @product = Product.new(name: "Yo-yo", description: "Test", price_cents: 400, :category => @category, quantity: 13)
      @product.save!
      expect(@product.id).to be_present
    end
  
    it "should not be valid without a name" do
      @category = Category.new(name: "Test")
      @product = Product.new(name: nil, description: "Test", price_cents: 400, :category => @category, quantity: 13)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

    it "should not be valid without a price" do
      @category = Category.new(name: "Test")
      @product = Product.new(name: "Yo-yo", description: "Test", price_cents: nil, :category => @category, quantity: 13)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it "should not be valid without a quantity" do
      @category = Category.new(name: "Test")
      @product = Product.new(name: "Yo-yo", description: "Test", price_cents: 400, :category => @category, quantity: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end
    
    it "should not be valid without a category" do
      @category = Category.new(name: "Test")
      @product = Product.new(name: "Yo-yo", description: "Test", price_cents: 400, :category => nil, quantity: 13)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end
  end

end
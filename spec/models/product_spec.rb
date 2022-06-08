require "rails_helper"

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before :each do 
      @category = Category.new name: "categoryX"
      @product = @category.products.new({ name: "Plant Y", description: "Plant Y does not need much water but does need lots of sun.", quantity: 8, price: 20})
    end

    context "when adding a new product to the database" do
      it "saves an item properly with all the required info" do
        expect(@product.save).to eq true
      end

    it "fails to see if it has a product name" do
      @category = Category.new(name: "categoryX")
      @product = Product.new(price: "20", quantity: "8", category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can not be blank")
    end


    it "fails to see if it has product price info" do
      @category = Category.new(name: "categoryX")
      @product = Product.new(name: "Plant Y", quantity: "8", category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can not be blank")

    end

    it "fails to see if it has info about product quantity" do
      @category = Category.new(name: "categoryX")
      @product = Product.new(name: "Plant Y", price: "20", category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can not be blank")

    end

    it "fails to see if there is a product category provided" do
      @category = Category.new(name: "categoryX")
      @product = Product.new(name: "Plant Y", price: "20", quantity: "8")
      @product.save
      expect(@product.errors.full_messages).to include("Category can not be blank")
    end
  end
end